import 'word_game_state.dart';

/// Kelime oyunu harf doğrulama utility sınıfı.
///
/// Kullanıcının yazdığı kelimenin mevcut harflerle
/// yazılıp yazılamayacağını kontrol eder.
class LetterValidation {
  /// Yazılan kelimenin mevcut harflerle yazılıp yazılamayacağını kontrol eder.
  ///
  /// [guess]: Kullanıcının yazdığı kelime.
  /// [availableLetters]: Mevcut 8 harf listesi.
  /// [jokerAvailable]: Joker kullanılabilir mi?
  ///
  /// Döndürür: [WordValidationResult] - doğrulama sonucu ve detaylar.
  static WordValidationResult validate({
    required String guess,
    required List<String> availableLetters,
    required bool jokerAvailable,
  }) {
    if (guess.isEmpty) {
      return const WordValidationResult(
        isValid: true,
        word: '',
      );
    }

    final upperGuess = _turkishToUpper(guess);
    final letterPool = List<String>.from(availableLetters);
    final invalidIndices = <int>[];
    var jokerUsed = false;
    String? jokerLetter;

    for (int i = 0; i < upperGuess.length; i++) {
      final char = upperGuess[i];

      // Havuzda bu harf var mı?
      final index = letterPool.indexOf(char);

      if (index != -1) {
        // Harfi havuzdan çıkar (her harf 1 kez kullanılabilir)
        letterPool.removeAt(index);
      } else if (jokerAvailable && !jokerUsed) {
        // Joker kullan
        jokerUsed = true;
        jokerLetter = char;
      } else {
        // Geçersiz harf
        invalidIndices.add(i);
      }
    }

    if (invalidIndices.isEmpty) {
      return WordValidationResult(
        isValid: true,
        word: upperGuess,
        jokerUsed: jokerUsed,
        jokerLetter: jokerLetter,
      );
    }

    // Geçersiz harfleri bul
    final invalidChars =
        invalidIndices.map((i) => upperGuess[i]).toSet().join(', ');

    return WordValidationResult(
      isValid: false,
      word: upperGuess,
      errorMessage: 'Geçersiz harf: $invalidChars',
      invalidLetterIndices: invalidIndices,
      jokerUsed: jokerUsed,
      jokerLetter: jokerLetter,
    );
  }

  /// Her harfin kullanım durumunu hesaplar (UI için).
  ///
  /// [guess]: Kullanıcının yazdığı kelime.
  /// [availableLetters]: Mevcut 8 harf listesi.
  ///
  /// Döndürür: Her harf için [LetterUse] listesi.
  static List<LetterUse> calculateLetterUsage({
    required String guess,
    required List<String> availableLetters,
  }) {
    final upperGuess = _turkishToUpper(guess);
    final result = <LetterUse>[];

    // Her harfin kaç kez kullanılabilir olduğunu takip et
    final usageCount = <int, int>{};

    for (int i = 0; i < availableLetters.length; i++) {
      final letter = _turkishToUpper(availableLetters[i]);
      var positionInGuess = _findPositionInGuess(
        letter,
        upperGuess,
        usageCount,
        i,
        availableLetters,
      );

      result.add(LetterUse(
        letter: letter,
        isUsed: positionInGuess != null,
        positionInGuess: positionInGuess,
      ));
    }

    return result;
  }

  /// Harfin kelimedeki pozisyonunu bulur.
  ///
  /// Aynı harften birden fazla varsa, her birini ayrı ayrı eşleştirir.
  static int? _findPositionInGuess(
    String letter,
    String guess,
    Map<int, int> usageCount,
    int letterIndex,
    List<String> availableLetters,
  ) {
    // Bu harfin tüm pozisyonlarını bul
    final positions = <int>[];
    for (int i = 0; i < guess.length; i++) {
      if (guess[i] == letter) {
        positions.add(i);
      }
    }

    if (positions.isEmpty) return null;

    // Bu harften önce kaç tane aynı harf var?
    int sameLettersBefore = 0;
    for (int i = 0; i < letterIndex; i++) {
      if (_turkishToUpper(availableLetters[i]) == letter) {
        sameLettersBefore++;
      }
    }

    // Eğer bu harfin kullanılabilecek pozisyonu varsa
    if (sameLettersBefore < positions.length) {
      return positions[sameLettersBefore];
    }

    return null;
  }

  /// Kelime için gerekli harflerin listesini döner.
  ///
  /// Joker kullanılıyorsa hangi harf için kullanıldığını belirtir.
  static ({
    List<String> requiredLetters,
    String? jokerFor,
  }) getRequiredLetters({
    required String word,
    required List<String> availableLetters,
    required bool jokerAvailable,
  }) {
    final upperWord = _turkishToUpper(word);
    final letterPool = List<String>.from(availableLetters);
    final required = <String>[];
    String? jokerFor;

    for (int i = 0; i < upperWord.length; i++) {
      final char = upperWord[i];
      final index = letterPool.indexOf(char);

      if (index != -1) {
        required.add(char);
        letterPool.removeAt(index);
      } else if (jokerAvailable && jokerFor == null) {
        jokerFor = char;
        required.add('*'); // Joker işareti
      }
    }

    return (requiredLetters: required, jokerFor: jokerFor);
  }

  /// Verilen harflerle yazılabilecek maksimum kelime uzunluğu.
  static int maxPossibleLength(List<String> letters, bool jokerAvailable) {
    return letters.length + (jokerAvailable ? 1 : 0);
  }

  /// Türkçe karakterleri doğru şekilde büyük harfe dönüştürür.
  /// Dart'ın toUpperCase() metodu Türkçe i/ı dönüşümünü doğru yapmaz.
  static String _turkishToUpper(String text) {
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
}
