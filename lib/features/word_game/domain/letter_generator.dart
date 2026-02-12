import 'dart:math';

/// Kelime oyunu için harf üreteci.
///
/// Türkçe harf frekanslarına göre ağırlıklı rastgele harf çeker.
/// Kurallar:
/// - Toplam 8 harf
/// - En az 3, en fazla 4 sesli harf
/// - Manuel (Sesli/Sessiz buton) veya Rastgele seçim
class LetterGenerator {
  LetterGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  /// Minimum sesli harf sayısı.
  static const int minVowels = 3;

  /// Maksimum sesli harf sayısı.
  static const int maxVowels = 4;

  /// Toplam harf sayısı.
  static const int totalLetters = 8;

  /// Türkçe sesli harfler.
  static const List<String> vowels = ['A', 'E', 'I', 'İ', 'O', 'Ö', 'U', 'Ü'];

  /// Türkçe sessiz harfler.
  static const List<String> consonants = [
    'B',
    'C',
    'Ç',
    'D',
    'F',
    'G',
    'Ğ',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'P',
    'R',
    'S',
    'Ş',
    'T',
    'V',
    'Y',
    'Z',
  ];

  /// Türkçe harf frekansları (TDK/akademik verilere dayalı).
  /// Değerler ağırlık olarak kullanılır (yüksek = daha sık).
  /// Kaynak: Türkçe metinlerdeki harf kullanım istatistikleri
  ///
  /// Sesli harfler toplamı: ~%32
  /// Sessiz harfler toplamı: ~%68
  static const Map<String, int> letterWeights = {
    // Sesli harfler (Türkçe metinlerde ~%32)
    'A': 119, // %11.92 - En sık sesli
    'E': 89,  // %8.91
    'İ': 79,  // %7.94
    'I': 51,  // %5.14
    'U': 32,  // %3.23
    'Ü': 19,  // %1.85
    'O': 25,  // %2.47
    'Ö': 8,   // %0.77

    // Sessiz harfler (Türkçe metinlerde ~%68)
    'N': 72,  // %7.23 - En sık sessiz
    'R': 67,  // %6.72
    'L': 59,  // %5.92
    'K': 47,  // %4.68
    'D': 47,  // %4.70
    'T': 31,  // %3.14
    'M': 37,  // %3.75
    'S': 30,  // %3.00
    'Y': 33,  // %3.34
    'B': 28,  // %2.84
    'Ş': 18,  // %1.78
    'Ç': 12,  // %1.15
    'Z': 15,  // %1.50
    'G': 13,  // %1.25
    'H': 11,  // %1.06
    'C': 10,  // %0.96
    'V': 10,  // %0.99
    'P': 8,   // %0.84
    'F': 4,   // %0.44
    'Ğ': 10,  // %1.00
    'J': 1,   // %0.03 - En nadir
  };

  /// Ağırlıklı rastgele sesli harf çeker.
  String drawVowel() {
    return _drawWeightedLetter(vowels);
  }

  /// Ağırlıklı rastgele sessiz harf çeker.
  String drawConsonant() {
    return _drawWeightedLetter(consonants);
  }

  /// Verilen harf listesinden ağırlıklı rastgele seçim yapar.
  String _drawWeightedLetter(List<String> letters) {
    final weights = letters.map((l) => letterWeights[l] ?? 1).toList();
    final totalWeight = weights.fold(0, (sum, w) => sum + w);

    var randomValue = _random.nextInt(totalWeight);

    for (int i = 0; i < letters.length; i++) {
      randomValue -= weights[i];
      if (randomValue < 0) {
        return letters[i];
      }
    }

    return letters.last;
  }

  /// Aynı harften maksimum kaç tane olabilir.
  /// Sessiz harfler tekrar etmemeli (her birinden max 1)
  /// Sesli harfler 2 kez olabilir (A-A gibi izin var)
  static const int maxSameConsonant = 1;
  static const int maxSameVowel = 2;

  /// 8 rastgele harf üretir (3-4 sesli garantili).
  /// Aynı sessiz harften sadece 1 tane olabilir (tekrar yok).
  /// Aynı sesli harften en fazla 2 tane olabilir.
  List<String> generateRandomLetters() {
    final result = <String>[];

    // Kaç sesli olacağını belirle (3 veya 4)
    final vowelCount = minVowels + _random.nextInt(maxVowels - minVowels + 1);
    final consonantCount = totalLetters - vowelCount;

    // Sesli harfleri ekle (aynı harften max 2)
    for (int i = 0; i < vowelCount; i++) {
      result.add(_drawVowelWithLimit(result));
    }

    // Sessiz harfleri ekle (aynı harften max 2)
    for (int i = 0; i < consonantCount; i++) {
      result.add(_drawConsonantWithLimit(result));
    }

    // Karıştır
    result.shuffle(_random);

    return result;
  }

  /// Aynı harften max 2 olacak şekilde sesli harf çeker.
  String _drawVowelWithLimit(List<String> current) {
    // Hangi harfler zaten 2 kez kullanıldı?
    final letterCounts = <String, int>{};
    for (final letter in current) {
      letterCounts[letter] = (letterCounts[letter] ?? 0) + 1;
    }

    // Kullanılabilir harfleri filtrele
    final availableVowels = vowels
        .where((v) => (letterCounts[v] ?? 0) < maxSameVowel)
        .toList();

    if (availableVowels.isEmpty) {
      // Tüm harfler doluysa herhangi birini seç (teorik olarak olmaz)
      return drawVowel();
    }

    return _drawWeightedLetter(availableVowels);
  }

  /// Aynı sessiz harften sadece 1 tane olacak şekilde sessiz harf çeker.
  String _drawConsonantWithLimit(List<String> current) {
    // Hangi harfler zaten kullanıldı?
    final letterCounts = <String, int>{};
    for (final letter in current) {
      letterCounts[letter] = (letterCounts[letter] ?? 0) + 1;
    }

    // Kullanılabilir harfleri filtrele
    final availableConsonants = consonants
        .where((c) => (letterCounts[c] ?? 0) < maxSameConsonant)
        .toList();

    if (availableConsonants.isEmpty) {
      // Tüm harfler doluysa herhangi birini seç (teorik olarak olmaz)
      return drawConsonant();
    }

    return _drawWeightedLetter(availableConsonants);
  }

  /// Mevcut harflere sesli harf ekler.
  ///
  /// Eğer sesli sayısı maksimuma ulaştıysa null döner.
  String? addVowelTo(List<String> current) {
    if (current.length >= totalLetters) return null;

    final currentVowelCount = _countVowels(current);

    // Eğer kalan slotların hepsi sessiz için gerekli değilse sesli eklenebilir
    if (currentVowelCount < maxVowels) {
      return drawVowel();
    }

    return null;
  }

  /// Mevcut harflere sessiz harf ekler.
  ///
  /// Eğer sessiz eklenemiyorsa (sesli minimum sağlanamayacaksa) null döner.
  String? addConsonantTo(List<String> current) {
    if (current.length >= totalLetters) return null;

    final currentVowelCount = _countVowels(current);
    final remainingSlots = totalLetters - current.length;
    final neededVowels = (minVowels - currentVowelCount).clamp(0, remainingSlots);

    // Eğer kalan slotlar sadece sesli için yeterliyse sessiz eklenemez
    if (remainingSlots <= neededVowels) {
      return null;
    }

    return drawConsonant();
  }

  /// Kalan harfleri otomatik tamamlar (3-4 sesli kuralına uygun).
  /// Aynı harften en fazla 2 tane olur.
  List<String> completeLetters(List<String> current) {
    if (current.length >= totalLetters) {
      return List.from(current);
    }

    final result = List<String>.from(current);
    final currentVowelCount = _countVowels(result);
    var remainingSlots = totalLetters - result.length;

    // Minimum sesli sayısını sağla
    var neededVowels = (minVowels - currentVowelCount).clamp(0, remainingSlots);

    // Maksimum sesli sayısını aşma
    final maxAdditionalVowels = maxVowels - currentVowelCount;
    neededVowels = neededVowels.clamp(0, maxAdditionalVowels);

    // Önce gerekli seslileri ekle (aynı harften max 2)
    for (int i = 0; i < neededVowels; i++) {
      result.add(_drawVowelWithLimit(result));
    }

    // Kalanları rastgele doldur (sesli/sessiz dengesini koru)
    remainingSlots = totalLetters - result.length;

    for (int i = 0; i < remainingSlots; i++) {
      // Eğer sesli max'a ulaştıysa sessiz ekle
      if (_countVowels(result) >= maxVowels) {
        result.add(_drawConsonantWithLimit(result));
      }
      // Eğer kalan slotlarda min sesliyi sağlayamayacaksak sesli ekle
      else if ((totalLetters - result.length - 1) <
          (minVowels - _countVowels(result))) {
        result.add(_drawVowelWithLimit(result));
      }
      // Rastgele seç (ağırlıklı)
      else {
        if (_random.nextBool()) {
          result.add(_drawVowelWithLimit(result));
        } else {
          result.add(_drawConsonantWithLimit(result));
        }
      }
    }

    return result;
  }

  /// Verilen harflerdeki sesli sayısını hesaplar.
  int _countVowels(List<String> letters) {
    return letters.where((l) => vowels.contains(l.toUpperCase())).length;
  }

  /// Verilen harf sesli mi?
  static bool isVowel(String letter) {
    return vowels.contains(letter.toUpperCase());
  }

  /// Verilen harf sessiz mi?
  static bool isConsonant(String letter) {
    return consonants.contains(letter.toUpperCase());
  }
}
