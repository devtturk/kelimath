import 'word_dictionary.dart';

/// Test/MVP için lokal mock sözlük.
///
/// ~1000 yaygın Türkçe kelime içerir.
/// Çekim ekleri olmadan sadece kök kelimeler ve yapım ekli türevler.
class MockDictionary implements WordDictionary {
  MockDictionary();

  /// Türkçe kelime seti (~1000 kelime).
  /// Alfabetik sıralı, büyük harf.
  static const Set<String> _words = {
    // A
    'ACI', 'ACIK', 'ACIL', 'AD', 'ADAM', 'ADIM', 'AĞ', 'AĞAÇ', 'AĞIR',
    'AĞIZ', 'AHİ', 'AİLE', 'AK', 'AKAN', 'AKAR', 'AKIL', 'AKIN', 'AKŞAM',
    'AL', 'ALAN', 'ALÇAK', 'ALİ', 'ALIM', 'ALIN', 'ALT', 'ALTI', 'ALTLIK',
    'AMA', 'AN', 'ANA', 'ANNE', 'ANT', 'AR', 'ARA', 'ARABA', 'ARAMA',
    'ARİ', 'ARKA', 'ARMUT', 'ARS', 'ASIL', 'ASKER', 'ASLAN', 'AT', 'ATA',
    'ATAK', 'ATEŞ', 'ATIK', 'ATIM', 'ATLAS', 'AVLU', 'AY', 'AYAK', 'AYAR',
    'AYI', 'AYLIK', 'AYNA', 'AYNI', 'AZ',
    // B
    'BABA', 'BACAK', 'BAĞ', 'BAHÇE', 'BAK', 'BAKIM', 'BAL', 'BALÇIK',
    'BALIK', 'BANK', 'BANKA', 'BARDAK', 'BARIŞ', 'BAS', 'BASIM', 'BASIT',
    'BASKI', 'BAŞ', 'BAŞAK', 'BAŞARI', 'BAŞKAN', 'BAŞLIK', 'BAT', 'BATI',
    'BAYRAK', 'BEK', 'BEKÇI', 'BEL', 'BELGE', 'BEN', 'BENZ', 'BESİ',
    'BEYAZ', 'BEZ', 'BIÇAK', 'BİLGİ', 'BİLİM', 'BİN', 'BİNA', 'BİR',
    'BİRİ', 'BİT', 'BİTKİ', 'BİZ', 'BOL', 'BOR', 'BORÇ', 'BOŞ', 'BOY',
    'BOYA', 'BOYUN', 'BOZ', 'BUĞDAY', 'BULGU', 'BULUT', 'BUN', 'BURUN',
    'BUT', 'BÜFE', 'BÜK', 'BÜRÜN', 'BÜYÜK',
    // C
    'CAM', 'CAN', 'CANLIL', 'CEP', 'CEZA', 'CİLT', 'CİNS', 'CİVAR', 'CUMA',
    // Ç
    'ÇABA', 'ÇAĞ', 'ÇAĞRI', 'ÇAKI', 'ÇALIK', 'ÇALIŞMA', 'ÇAM', 'ÇAMUR',
    'ÇAN', 'ÇANTA', 'ÇAP', 'ÇAR', 'ÇARE', 'ÇARŞI', 'ÇAT', 'ÇATI', 'ÇAY',
    'ÇEK', 'ÇELIK', 'ÇEM', 'ÇENGİ', 'ÇEP', 'ÇEVRE', 'ÇİÇEK', 'ÇİFT',
    'ÇİLEK', 'ÇİMEN', 'ÇİN', 'ÇİT', 'ÇİZGİ', 'ÇOCUK', 'ÇOK', 'ÇORAP', 'ÇORBA',
    'ÇUBUK', 'ÇUKUR',
    // D
    'DAĞ', 'DAĞIL', 'DAİRE', 'DAK', 'DAKİKA', 'DAL', 'DALGA', 'DAM',
    'DAMLA', 'DAR', 'DAVET', 'DEDE', 'DEĞİŞ', 'DELIK', 'DEMİR', 'DEN',
    'DENİZ', 'DER', 'DERİ', 'DERS', 'DEV', 'DEVAM', 'DEVLET', 'DIŞ',
    'DIŞARI', 'DİK', 'DİKKAT', 'DIL', 'DİN', 'DİŞ', 'DİZİ', 'DOĞA',
    'DOĞRU', 'DOĞUM', 'DOKTOR', 'DOLU', 'DOLUM', 'DOM', 'DOMUZ', 'DON',
    'DOST', 'DÖNEM', 'DÖNÜŞ', 'DÖRT', 'DUA', 'DURAK', 'DURUM', 'DUVAR',
    'DUY', 'DUYGU', 'DÜĞME', 'DÜNYA', 'DÜŞ', 'DÜŞMAN', 'DÜZ', 'DÜZEN',
    // E
    'EĞİTİM', 'EK', 'EKMEK', 'EKİP', 'EL', 'ELBİSE', 'ELMA', 'EMEĞİ',
    'EMEK', 'EN', 'ENDİŞE', 'ENERJİ', 'ER', 'ERKEK', 'ERTESİ', 'ESKİ',
    'ET', 'ETEK', 'ETKİ', 'EV', 'EVRAK', 'EYL',
    // F
    'FABRIKA', 'FAK', 'FAKİR', 'FAN', 'FARE', 'FARK', 'FELİK', 'FEN',
    'FER', 'FİKİR', 'FİL', 'FİLM', 'FIRÇA', 'FIRIN', 'FISTIK', 'FORMA',
    // G
    'GAZ', 'GAZETE', 'GEÇİŞ', 'GEL', 'GELİR', 'GELİŞ', 'GEMI', 'GEN',
    'GENÇ', 'GENEL', 'GENİŞ', 'GERÇEK', 'GERİ', 'GEZ', 'GİRİŞ', 'GİYİM',
    'GİYSİ', 'GÖK', 'GÖL', 'GÖLGE', 'GÖMLEK', 'GÖR', 'GÖREV', 'GÖRÜŞ',
    'GÖZ', 'GÖZLÜK', 'GRUP', 'GÜÇ', 'GÜL', 'GÜLMEK', 'GÜMÜŞ', 'GÜN',
    'GÜNEŞ', 'GÜNLÜK', 'GÜR', 'GÜRÜLTÜ', 'GÜVEN', 'GÜZEL',
    // H
    'HABER', 'HAFTA', 'HAK', 'HAKIM', 'HAL', 'HALA', 'HALK', 'HANE',
    'HANGİ', 'HANI', 'HAP', 'HARÇ', 'HARİTA', 'HASRET', 'HASTA', 'HAT',
    'HATA', 'HATIR', 'HAVA', 'HAVLU', 'HAVUZ', 'HAYAT', 'HAYAL', 'HAYIR',
    'HAYVAN', 'HEM', 'HEP', 'HEDEF', 'HESAP', 'HİÇ', 'HİKAYE', 'HİS',
    'HİZMET', 'HOŞ', 'HUKUK',
    // I/İ
    'IRMAK', 'IŞIK', 'İÇ', 'İÇİN', 'İĞNE', 'İK', 'İKİ', 'İL', 'İLAÇ',
    'İLE', 'İLERİ', 'İLGİ', 'İLK', 'İLKE', 'İMKAN', 'İNCE', 'İNSAN',
    'İŞ', 'İŞÇİ', 'İYİ', 'İZ', 'İZİN',
    // J
    'JALE', 'JEL', 'JİLET',
    // K
    'KABIN', 'KABUK', 'KAÇIŞ', 'KADAR', 'KADIN', 'KAFA', 'KAĞIT', 'KAHVE',
    'KAL', 'KALEM', 'KALIP', 'KALİTE', 'KALK', 'KALP', 'KAMP', 'KAN',
    'KANAL', 'KANAT', 'KANI', 'KANIT', 'KANUN', 'KAP', 'KAPAK', 'KAPI',
    'KAR', 'KARA', 'KARAR', 'KARDEŞİ', 'KARŞI', 'KASIM', 'KAT', 'KATI',
    'KATLIK', 'KAVGA', 'KAVRAM', 'KAVUN', 'KAY', 'KAYA', 'KAYIP', 'KAYIT',
    'KAYNAK', 'KAZ', 'KAZAN', 'KAZI', 'KEL', 'KELİME', 'KEM', 'KEMIK',
    'KENE', 'KENT', 'KER', 'KERE', 'KERVAN', 'KESİK', 'KEŞİF', 'KIBLE',
    'KIL', 'KILIK', 'KILIÇ', 'KIM', 'KIP', 'KIR', 'KIRIK', 'KIS', 'KISA',
    'KISIM', 'KIT', 'KİLO', 'KİM', 'KİRA', 'KİŞİ', 'KİTAP', 'KOD', 'KOL',
    'KOLAY', 'KOM', 'KOMŞU', 'KONU', 'KONUM', 'KOR', 'KORKU', 'KORUMA',
    'KOŞ', 'KOŞU', 'KOVA', 'KÖK', 'KÖMÜR', 'KÖPEK', 'KÖPRÜ', 'KÖR',
    'KÖŞE', 'KÖY', 'KRAL', 'KREM', 'KULE', 'KULAK', 'KULÜP', 'KUM',
    'KUMAŞ', 'KURAK', 'KURAL', 'KURBAN', 'KURS', 'KURŞUN', 'KURT',
    'KURUL', 'KURUM', 'KURUŞ', 'KUS', 'KUŞ', 'KUTU', 'KUYU', 'KUZEY',
    'KUZU', 'KÜÇÜK', 'KÜFÜR', 'KÜL', 'KÜLTÜR', 'KÜP',
    // L
    'LAMBA', 'LAN', 'LASTIK', 'LEKE', 'LİMAN', 'LİMON', 'LİSAN', 'LİSE',
    'LİSTE', 'LİTRE', 'LOKMA',
    // M
    'MADEN', 'MAĞ', 'MAHALLE', 'MAKAM', 'MAKINE', 'MAL', 'MALZEME', 'MANA',
    'MANAV', 'MANGA', 'MANZARA', 'MARKET', 'MARTI', 'MASA', 'MASRAF',
    'MAT', 'MATEM', 'MAVİ', 'MAYO', 'MEKTUP', 'MEL', 'MELEK', 'MEMUR',
    'MERA', 'MESAFE', 'MESAJ', 'MESLEK', 'METAL', 'MEVSIM', 'MEYDAN',
    'MEYVE', 'MİDE', 'MİL', 'MİLLET', 'MİLYON', 'MİSAFİR', 'MOBİLYA',
    'MODA', 'MODERN', 'MOTOR', 'MUTFAK', 'MÜD', 'MÜZİK',
    // N
    'NANE', 'NAR', 'NASİL', 'NE', 'NEDEN', 'NEFİS', 'NEHİR', 'NEŞ',
    'NEVİ', 'NİSAN', 'NİŞAN', 'NOKTA', 'NOT', 'NUR', 'NUMARA',
    // O/Ö
    'OCA', 'OCAK', 'ODA', 'ODUN', 'OĞLAN', 'OĞUL', 'OK', 'OKUL', 'OKUR',
    'OL', 'OLAY', 'OMU', 'OMUZ', 'ON', 'ONUR', 'ORDU', 'ORMAN', 'ORTA',
    'ORTAK', 'OTEL', 'OTOBÜS', 'OTOPARK', 'OYMA', 'OYUN', 'OYUNCU',
    'ÖĞ', 'ÖĞLE', 'ÖĞRENİM', 'ÖLÇÜ', 'ÖLÜM', 'ÖMÜR', 'ÖN', 'ÖNEM',
    'ÖNERİ', 'ÖPÜCÜK', 'ÖR', 'ÖRNEK', 'ÖRS', 'ÖRTÜ', 'ÖYKÜ', 'ÖZ',
    'ÖZGÜR', 'ÖZEL',
    // P
    'PAKET', 'PALT', 'PAMUK', 'PANCAR', 'PARA', 'PARÇA', 'PARK', 'PARSEL',
    'PARTİ', 'PAS', 'PASTA', 'PATATES', 'PATLAMA', 'PATRON', 'PAZAR',
    'PEK', 'PENCERE', 'PERDE', 'PERİ', 'PES', 'PİL', 'PINAR', 'PİŞMAN',
    'PLAN', 'PLASTİK', 'POSTA', 'POT', 'PRENS', 'PROJE', 'PUAN',
    // R
    'RADYO', 'RAĞ', 'RAK', 'RAKI', 'RAKIM', 'RENK', 'RESİM', 'RICA',
    'ROTA', 'RÜYA', 'RÜZGAR',
    // S
    'SAAT', 'SABAH', 'SABIR', 'SAÇ', 'SAĞ', 'SAĞLIK', 'SAHİL', 'SAHİP',
    'SAKI', 'SAKİN', 'SAKIM', 'SALAM', 'SALON', 'SAM', 'SAN', 'SANAT',
    'SANDALİ', 'SANİYE', 'SARKI', 'SARI', 'SAT', 'SATIŞ', 'SATIR',
    'SAVUNMA', 'SAY', 'SAYI', 'SAYFA', 'SEBZE', 'SED', 'SEÇİM', 'SEL',
    'SEN', 'SENE', 'SENİ', 'SER', 'SERİ', 'SERVET', 'SES', 'SESSİZ',
    'SET', 'SEVDA', 'SEVGİ', 'SEVİNÇ', 'SICAK', 'SIK', 'SINIF', 'SINIR',
    'SIR', 'SIRA', 'SIRT', 'SİGARA', 'SİLAH', 'SİS', 'SİSTEM', 'SİYAH',
    'SOĞUK', 'SOK', 'SOKAK', 'SOL', 'SON', 'SONUÇ', 'SORU', 'SORUN',
    'SÖZ', 'SPOR', 'SU', 'SUCUK', 'SUNUCU', 'SUR', 'SURAT', 'SURİYE',
    'SUSAM', 'SÜR', 'SÜRE', 'SÜRÜ', 'SÜT',
    // Ş
    'ŞAFAK', 'ŞAİR', 'ŞAKA', 'ŞANS', 'ŞAP', 'ŞARAPİ', 'ŞART', 'ŞAŞKIN',
    'ŞATO', 'ŞAYAN', 'ŞEHİR', 'ŞEKER', 'ŞEKİL', 'ŞEMSIYE', 'ŞEREF',
    'ŞEY', 'ŞİİR', 'ŞİKAYET', 'ŞİMDİ', 'ŞİŞE', 'ŞOK', 'ŞÖYLE', 'ŞU',
    'ŞUBE', 'ŞÜPHE',
    // T
    'TABLO', 'TAÇ', 'TAKİP', 'TAKIM', 'TAKSİ', 'TAL', 'TALEP', 'TAM',
    'TANE', 'TANIK', 'TANITIM', 'TARAK', 'TARAF', 'TARİF', 'TARİH',
    'TARLA', 'TAS', 'TAŞ', 'TATLI', 'TAV', 'TAVAN', 'TAVIR', 'TAVUK',
    'TEBRİK', 'TECRÜBE', 'TEHLİKE', 'TEK', 'TEKER', 'TEKNE', 'TEMEL',
    'TEMİZ', 'TEPE', 'TER', 'TERS', 'TESİS', 'TEŞ', 'TEŞEKKÜR', 'TIR',
    'TIRNAK', 'TİCARET', 'TİP', 'TİYATRO', 'TOK', 'TOP', 'TOPLAM',
    'TOPLUM', 'TOPRAK', 'TOPLANTI', 'TOR', 'TORBA', 'TOST', 'TOZ', 'TÖREN',
    'TRAFİK', 'TUN', 'TUR', 'TURİST', 'TUTKU', 'TUTUM', 'TUZ', 'TÜM',
    'TÜRK', 'TÜR', 'TÜZEL',
    // U/Ü
    'UÇAK', 'UÇ', 'UÇUŞ', 'UFAK', 'UĞUR', 'ULU', 'ULUS', 'UMUT', 'UN',
    'UNVAN', 'US', 'USUL', 'USTA', 'UZAK', 'UZAY', 'UZMAN', 'UZUN',
    'ÜCRET', 'ÜLK', 'ÜLKE', 'ÜN', 'ÜNİVERSİTE', 'ÜRETİM', 'ÜRÜN',
    'ÜST', 'ÜYE', 'ÜZÜM',
    // V
    'VAAD', 'VADİ', 'VAGON', 'VAKIT', 'VAL', 'VALI', 'VANA', 'VAR',
    'VARIL', 'VASIF', 'VASITA', 'VATAN', 'VEFA', 'VER', 'VERGİ', 'VERİ',
    'VET', 'VİDEO', 'VİZE', 'VOLTA',
    // Y
    'YA', 'YABAN', 'YAĞ', 'YAĞMUR', 'YAKA', 'YAKIN', 'YAKIT', 'YALI',
    'YALIN', 'YAM', 'YAMUK', 'YAN', 'YANIK', 'YAPIT', 'YAPI', 'YAR',
    'YARA', 'YARAR', 'YARDIM', 'YARI', 'YARIN', 'YARIŞ', 'YAS', 'YAŞ',
    'YAŞAM', 'YATAK', 'YATAY', 'YATIRIM', 'YAVRU', 'YAYA', 'YAYIN',
    'YAZ', 'YAZI', 'YAZIK', 'YEDİ', 'YEL', 'YELEK', 'YEM', 'YEMEK',
    'YENİ', 'YER', 'YEREL', 'YEŞİL', 'YETENEK', 'YETIM', 'YETKİ', 'YIL',
    'YILDIZ', 'YIKIM', 'YİNE', 'YOĞ', 'YOĞURT', 'YOK', 'YOL', 'YOLCU',
    'YOLCULUK', 'YON', 'YÖN', 'YÖNETIM', 'YORUM', 'YÖRESİ', 'YURT',
    'YÜK', 'YÜKSEK', 'YÜN', 'YÜREK', 'YÜZ', 'YÜZDE', 'YÜZEY', 'YÜZÜK',
    // Z
    'ZAMAN', 'ZARAR', 'ZARF', 'ZAR', 'ZATEN', 'ZAYIF', 'ZEMIN', 'ZEN',
    'ZENGİN', 'ZEYT', 'ZEYTİN', 'ZİL', 'ZİNCİR', 'ZOR', 'ZORLU',
  };

  @override
  Future<void> initialize() async {
    // Mock dictionary is always ready
  }

  @override
  Future<bool> isValidWord(String word) async {
    return _words.contains(word.toUpperCase().trim());
  }

  @override
  Future<String?> getDefinition(String word) async {
    // MVP'de tanım yok
    return null;
  }

  @override
  Future<List<String>> findValidWords(
    List<String> letters, {
    bool includeJoker = true,
  }) async {
    final upperLetters = letters.map((l) => l.toUpperCase()).toList();
    final result = <String>[];

    for (final word in _words) {
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
    return _words.length;
  }

  @override
  Future<bool> isReady() async {
    return true;
  }

  /// Verilen harflerle kelime oluşturulabilir mi kontrol eder.
  bool _canFormWord(String word, List<String> letters, bool useJoker) {
    final letterPool = List<String>.from(letters);
    var jokerUsed = false;

    for (int i = 0; i < word.length; i++) {
      final char = word[i];
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

  /// Sözlükteki tüm kelimeleri döner (test için).
  Set<String> get allWords => _words;
}
