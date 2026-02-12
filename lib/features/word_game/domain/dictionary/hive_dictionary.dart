import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'word_dictionary.dart';

/// Hive tabanlı Türkçe sözlük implementasyonu.
///
/// Asset dosyasından yüklenip Hive'a kaydedilir.
/// İlk açılışta asset'ten yüklenir, sonraki açılışlarda
/// Hive'dan hızlıca okunur.
class HiveDictionary implements WordDictionary {
  static const String _boxName = 'dictionary';
  static const String _wordsKey = 'words';
  static const String _versionKey = 'version';
  static const String _assetPath = 'assets/dictionary/turkish_words.txt';

  // Mevcut sözlük versiyonu (asset güncellendiğinde artır)
  // v2: Türkçe karakter dönüşümü düzeltildi
  // v3: I/İ karakter sorunu düzeltildi, 37 yeni kelime eklendi (KÖRİ, ABİ, AİLE, vb.)
  // v4: TDK'dan yeni sözlük indirildi (60,019 kelime), doğru İ/I ayrımı
  // v5: Cache zorla yenilendi - İ/I sorunu tamamen çözüldü
  static const int _currentVersion = 5;

  Box? _box;
  Set<String> _wordSet = {};
  bool _isInitialized = false;
  Future<void>? _initFuture;

  /// Sözlüğü başlat.
  Future<void> initialize() {
    _initFuture ??= _doInitialize();
    return _initFuture!;
  }

  Future<void> _doInitialize() async {
    if (_isInitialized) return;

    _box = await Hive.openBox(_boxName);

    // Versiyon kontrolü
    final savedVersion = _box!.get(_versionKey, defaultValue: 0);

    if (savedVersion != _currentVersion) {
      // Asset'ten yükle
      await _loadFromAsset();
    } else {
      // Hive'dan yükle
      await _loadFromHive();
    }

    _isInitialized = true;
  }

  /// Asset dosyasından kelimeleri yükle.
  Future<void> _loadFromAsset() async {
    try {
      final data = await rootBundle.loadString(_assetPath);
      // Asset zaten büyük harfle, sadece trim ve filtrele
      final words = LineSplitter.split(data)
          .map((line) => line.trim())
          .where((word) => word.isNotEmpty && word.length >= 2)
          .toSet();

      _wordSet = words;

      // Hive'a kaydet
      await _box!.put(_wordsKey, words.toList());
      await _box!.put(_versionKey, _currentVersion);
    } catch (_) {
      // Asset bulunamazsa fallback kelimeleri kullan
      _wordSet = _fallbackWords;
    }
  }

  /// Hive'dan kelimeleri yükle.
  Future<void> _loadFromHive() async {
    final wordsList = _box!.get(_wordsKey, defaultValue: <String>[]);
    _wordSet = Set<String>.from(wordsList);

    // Boşsa fallback'e dön
    if (_wordSet.isEmpty) {
      _wordSet = _fallbackWords;
    }
  }

  @override
  Future<bool> isValidWord(String word) async {
    if (!_isInitialized) await initialize();
    final normalizedWord = _turkishToUpper(word.trim());
    return _wordSet.contains(normalizedWord);
  }

  @override
  Future<String?> getDefinition(String word) async {
    // Tanımlar için ayrı bir sistem gerekir
    // Şimdilik null döndürüyoruz
    return null;
  }

  @override
  Future<List<String>> findValidWords(
    List<String> letters, {
    bool includeJoker = true,
  }) async {
    if (!_isInitialized) await initialize();

    final upperLetters = letters.map((l) => _turkishToUpper(l)).toList();
    final result = <String>[];

    for (final word in _wordSet) {
      if (_canFormWord(word, upperLetters, includeJoker)) {
        result.add(word);
      }
    }

    // Uzunluğa göre azalan sırada sırala
    result.sort((a, b) => b.length.compareTo(a.length));

    return result;
  }

  @override
  Future<int> getWordCount() async {
    if (!_isInitialized) await initialize();
    return _wordSet.length;
  }

  @override
  Future<bool> isReady() async {
    return _isInitialized;
  }

  /// Verilen harflerle kelime oluşturulabilir mi kontrol eder.
  bool _canFormWord(String word, List<String> letters, bool useJoker) {
    // Türkçe büyük harfe dönüştür
    final normalizedWord = _turkishToUpper(word);
    final letterPool = letters.map((l) => _turkishToUpper(l)).toList();
    var jokerUsed = false;

    for (int i = 0; i < normalizedWord.length; i++) {
      final char = normalizedWord[i];
      final index = letterPool.indexOf(char);

      if (index != -1) {
        letterPool.removeAt(index);
      } else if (useJoker && !jokerUsed) {
        jokerUsed = true;
      } else {
        return false;
      }
    }

    return true;
  }

  /// Türkçe karakterleri doğru şekilde büyük harfe dönüştürür.
  /// Dart'ın toUpperCase() metodu Türkçe i/ı dönüşümünü doğru yapmaz.
  String _turkishToUpper(String text) {
    const turkishLowerToUpper = {
      'i': 'İ', // noktalı i -> noktalı İ
      'ı': 'I', // noktasız ı -> noktasız I
      'ğ': 'Ğ',
      'ü': 'Ü',
      'ş': 'Ş',
      'ö': 'Ö',
      'ç': 'Ç',
    };

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      buffer.write(turkishLowerToUpper[char] ?? char.toUpperCase());
    }
    return buffer.toString();
  }

  /// Asset yoksa kullanılacak fallback kelimeler.
  static final Set<String> _fallbackWords = {
    // Yaygın Türkçe kelimeler (kısaltılmış liste)
    'ACI', 'ACIK', 'AD', 'ADAM', 'ADIM', 'AĞAÇ', 'AĞIR', 'AĞIZ', 'AİLE',
    'AK', 'AKAN', 'AKIL', 'AL', 'ALAN', 'ALT', 'ALTI', 'AMA', 'AN', 'ANA',
    'ANNE', 'AR', 'ARA', 'ARABA', 'ARKA', 'AT', 'ATA', 'ATEŞ', 'AY', 'AYAK',
    'AYI', 'AYNA', 'AZ', 'BABA', 'BACAK', 'BAĞ', 'BAHÇE', 'BAK', 'BAL',
    'BALIK', 'BANK', 'BANKA', 'BARDAK', 'BAS', 'BAŞ', 'BAŞAK', 'BAŞARI',
    'BAT', 'BATI', 'BEK', 'BEL', 'BEN', 'BEYAZ', 'BİLGİ', 'BİLİM', 'BİN',
    'BİNA', 'BİR', 'BİT', 'BİZ', 'BOL', 'BORÇ', 'BOŞ', 'BOY', 'BOYA',
    'BÜYÜK', 'CAM', 'CAN', 'CEP', 'CEZA', 'CUMA', 'ÇABA', 'ÇAĞ', 'ÇAM',
    'ÇANTA', 'ÇAY', 'ÇEVRE', 'ÇİÇEK', 'ÇİFT', 'ÇOCUK', 'ÇOK', 'DAĞ',
    'DAİRE', 'DAL', 'DALGA', 'DAM', 'DAMLA', 'DAR', 'DEDE', 'DEMİR',
    'DENİZ', 'DERİ', 'DERS', 'DEV', 'DEVAM', 'DIŞ', 'DİK', 'DİL', 'DİN',
    'DİŞ', 'DOĞA', 'DOĞRU', 'DOKTOR', 'DOLU', 'DOMUZ', 'DON', 'DOST',
    'DÖRT', 'DURAK', 'DURUM', 'DUVAR', 'DUYGU', 'DÜNYA', 'DÜZ', 'EĞİTİM',
    'EK', 'EKMEK', 'EL', 'ELMA', 'EMEK', 'EN', 'ENERJİ', 'ER', 'ERKEK',
    'ESKİ', 'ET', 'ETKİ', 'EV', 'FABRİKA', 'FAKİR', 'FARE', 'FARK', 'FEN',
    'FİKİR', 'FİL', 'FİLM', 'FIRMA', 'GAZ', 'GAZETE', 'GEL', 'GELİR',
    'GEMI', 'GEN', 'GENÇ', 'GENEL', 'GENİŞ', 'GERÇEK', 'GERİ', 'GÖK',
    'GÖL', 'GÖLGE', 'GÖR', 'GÖREV', 'GÖZ', 'GRUP', 'GÜÇ', 'GÜL', 'GÜMÜŞ',
    'GÜN', 'GÜNEŞ', 'GÜVEN', 'GÜZEL', 'HABER', 'HAFTA', 'HAK', 'HAL',
    'HALK', 'HAP', 'HASTA', 'HAT', 'HATA', 'HAVA', 'HAVLU', 'HAVUZ',
    'HAYAT', 'HAYAL', 'HAYVAN', 'HEM', 'HEP', 'HEDEF', 'HESAP', 'HİÇ',
    'HİS', 'HOŞ', 'IRMAK', 'IŞIK', 'İÇ', 'İÇİN', 'İK', 'İKİ', 'İL',
    'İLAÇ', 'İLE', 'İLERİ', 'İLGİ', 'İLK', 'İMKAN', 'İNCE', 'İNSAN',
    'İŞ', 'İŞÇİ', 'İYİ', 'İZ', 'KADIN', 'KAFA', 'KAĞIT', 'KAHVE', 'KAL',
    'KALEM', 'KALP', 'KAN', 'KANAL', 'KANAT', 'KANUN', 'KAP', 'KAPAK',
    'KAPI', 'KAR', 'KARA', 'KARAR', 'KARŞI', 'KAT', 'KAVGA', 'KAVUN',
    'KAY', 'KAYA', 'KAYNAK', 'KAZ', 'KAZAN', 'KELİME', 'KEMIK', 'KENT',
    'KILIK', 'KILIÇ', 'KIR', 'KIS', 'KISA', 'KİLO', 'KİM', 'KİRA', 'KİŞİ',
    'KİTAP', 'KOL', 'KOLAY', 'KOMŞU', 'KONU', 'KORKU', 'KORUMA', 'KOVA',
    'KÖK', 'KÖMÜR', 'KÖPEK', 'KÖPRÜ', 'KÖR', 'KÖŞE', 'KÖY', 'KRAL',
    'KULE', 'KULAK', 'KUM', 'KURAL', 'KURT', 'KURUM', 'KUŞ', 'KUTU',
    'KUYU', 'KUZEY', 'KUZU', 'KÜÇÜK', 'KÜL', 'KÜLTÜR', 'LAMBA', 'LEKE',
    'LİMAN', 'LİMON', 'LİSE', 'LİSTE', 'MADEN', 'MAHALLE', 'MAKAM',
    'MAKİNE', 'MAL', 'MANA', 'MARKET', 'MASA', 'MAVİ', 'MEKTUP', 'MELEK',
    'MEMUR', 'MESAFE', 'MESAJ', 'MESLEK', 'METAL', 'MEVSİM', 'MEYDAN',
    'MEYVE', 'MİDE', 'MİLLET', 'MİSAFİR', 'MODA', 'MOTOR', 'MUTFAK',
    'MÜZİK', 'NANE', 'NAR', 'NE', 'NEDEN', 'NEHİR', 'NİSAN', 'NOKTA',
    'NOT', 'NUMARA', 'OCAK', 'ODA', 'ODUN', 'OĞUL', 'OK', 'OKUL', 'OLAY',
    'OMUZ', 'ON', 'ONUR', 'ORDU', 'ORMAN', 'ORTA', 'ORTAK', 'OTEL',
    'OTOBÜS', 'OYUN', 'ÖĞ', 'ÖĞLE', 'ÖLÇÜ', 'ÖLÜM', 'ÖMÜR', 'ÖN', 'ÖNEM',
    'ÖRNEK', 'ÖRTÜ', 'ÖYKÜ', 'ÖZ', 'ÖZGÜR', 'ÖZEL', 'PAKET', 'PAMUK',
    'PARA', 'PARÇA', 'PARK', 'PARTİ', 'PASTA', 'PATATES', 'PATRON',
    'PAZAR', 'PENCERE', 'PERDE', 'PERİ', 'PİL', 'PLAN', 'POSTA', 'PROJE',
    'PUAN', 'RADYO', 'RENK', 'RESİM', 'RÜYA', 'RÜZGAR', 'SAAT', 'SABAH',
    'SAÇ', 'SAĞ', 'SAĞLIK', 'SAHİL', 'SAKİN', 'SALON', 'SANAT', 'SANİYE',
    'SARKI', 'SARI', 'SATIŞ', 'SAY', 'SAYI', 'SAYFA', 'SEBZE', 'SEÇİM',
    'SEL', 'SEN', 'SENE', 'SERİ', 'SES', 'SET', 'SEVDA', 'SEVGİ',
    'SICAK', 'SINIF', 'SINIR', 'SIR', 'SIRA', 'SİGARA', 'SİLAH', 'SİS',
    'SİSTEM', 'SİYAH', 'SOĞUK', 'SOKAK', 'SOL', 'SON', 'SONUÇ', 'SORU',
    'SORUN', 'SÖZ', 'SPOR', 'SU', 'SUCUK', 'SÜR', 'SÜRE', 'SÜT', 'ŞAFAK',
    'ŞAİR', 'ŞAKA', 'ŞANS', 'ŞART', 'ŞATO', 'ŞEHİR', 'ŞEKER', 'ŞEKİL',
    'ŞEY', 'ŞİİR', 'ŞİMDİ', 'ŞİŞE', 'ŞOK', 'ŞU', 'ŞUBE', 'ŞÜPHE', 'TABLO',
    'TAÇ', 'TAKIM', 'TAKSİ', 'TALEP', 'TAM', 'TANE', 'TARAF', 'TARİH',
    'TARLA', 'TAŞ', 'TATLI', 'TAVAN', 'TAVUK', 'TEHLİKE', 'TEK', 'TEKNE',
    'TEMEL', 'TEMİZ', 'TEPE', 'TER', 'TERS', 'TIRNAK', 'TİCARET', 'TİP',
    'TİYATRO', 'TOP', 'TOPLAM', 'TOPLUM', 'TOPRAK', 'TORBA', 'TOZ',
    'TRAFİK', 'TUR', 'TURİST', 'TUTKU', 'TUZ', 'TÜM', 'TÜRK', 'TÜR',
    'UÇAK', 'UÇ', 'UFAK', 'UMUT', 'UN', 'USTA', 'UZAK', 'UZAY', 'UZMAN',
    'UZUN', 'ÜCRET', 'ÜLKE', 'ÜN', 'ÜRÜN', 'ÜST', 'ÜYE', 'ÜZÜM', 'VADİ',
    'VAGON', 'VAKİT', 'VAR', 'VATAN', 'VERGİ', 'VERİ', 'VİDEO', 'VİZE',
    'YA', 'YAĞ', 'YAĞMUR', 'YAKA', 'YAKIN', 'YAKIT', 'YAN', 'YAPIT',
    'YAPI', 'YAR', 'YARA', 'YARAR', 'YARDIM', 'YARI', 'YARIN', 'YARIŞ',
    'YAŞ', 'YAŞAM', 'YATAK', 'YATIRIM', 'YAVRU', 'YAYA', 'YAYIN', 'YAZ',
    'YAZI', 'YEDİ', 'YEL', 'YELEK', 'YEM', 'YEMEK', 'YENİ', 'YER',
    'YEREL', 'YEŞİL', 'YETENEK', 'YETKİ', 'YIL', 'YILDIZ', 'YİNE', 'YOK',
    'YOL', 'YOLCU', 'YÖN', 'YÖNETİM', 'YORUM', 'YURT', 'YÜK', 'YÜKSEK',
    'YÜN', 'YÜREK', 'YÜZ', 'YÜZEY', 'YÜZÜK', 'ZAMAN', 'ZARAR', 'ZARF',
    'ZAR', 'ZATEN', 'ZAYIF', 'ZEMİN', 'ZENGİN', 'ZEYTİN', 'ZİL', 'ZOR',
  };
}
