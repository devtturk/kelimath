/// Kelime oyunu puanlama hesaplamaları.
///
/// Puanlama kuralları:
/// - Her standart harf: 10 puan
/// - Joker harf: 5 puan
/// - 9 harfli tam kelime (8 harf + joker): Sabit 120 puan
/// - Zaman bonusu: Kalan saniye x 1 (sadece geçerli kelime için)
abstract final class WordScoringUtils {
  /// Standart harf puanı.
  static const int letterScore = 10;

  /// Joker harf puanı.
  static const int jokerScore = 5;

  /// 9 harfli tam kelime bonusu (sabit puan).
  static const int fullWordBonus = 120;

  /// Tur süresi (saniye).
  static const int roundDuration = 60;

  /// Minimum kelime uzunluğu.
  static const int minWordLength = 3;

  /// Maksimum kelime uzunluğu (8 harf + 1 joker).
  static const int maxWordLength = 9;

  /// Kelime puanını hesaplar.
  ///
  /// [letterCount]: Toplam harf sayısı (joker dahil).
  /// [jokerUsed]: Joker kullanıldı mı?
  ///
  /// 9 harfli tam kelime için sabit 120 puan verilir.
  /// Aksi halde: (harf sayısı - joker) * 10 + joker * 5
  static int calculateWordScore({
    required int letterCount,
    required bool jokerUsed,
  }) {
    // Geçersiz kelime kontrolü
    if (letterCount < minWordLength) {
      return 0;
    }

    // 9 harfli tam kelime bonusu
    if (letterCount == maxWordLength && jokerUsed) {
      return fullWordBonus;
    }

    // Normal hesaplama
    if (jokerUsed) {
      // Joker 1 harf sayılır, 5 puan değerinde
      final normalLetters = letterCount - 1;
      return (normalLetters * letterScore) + jokerScore;
    }

    return letterCount * letterScore;
  }

  /// 9 harfli tam kelime mi kontrol eder.
  static bool isFullWord(int letterCount, bool jokerUsed) {
    return letterCount == maxWordLength && jokerUsed;
  }

  /// Sadece taban puanı hesaplar (zaman bonusu olmadan).
  /// Kelime listesinde tahmini puan göstermek için kullanılır.
  static int calculateBaseScore({
    required int letterCount,
    required bool jokerUsed,
  }) {
    return calculateWordScore(letterCount: letterCount, jokerUsed: jokerUsed);
  }

  /// Zaman bonusunu hesaplar.
  ///
  /// Sadece geçerli kelime için bonus verilir (baseScore > 0).
  /// Formül: Kalan saniye x 1
  static int calculateTimeBonus(int timeRemaining, int baseScore) {
    if (baseScore <= 0) {
      return 0;
    }

    return timeRemaining.clamp(0, roundDuration);
  }

  /// Toplam puanı hesaplar.
  ///
  /// Döndürür: (baseScore, timeBonus, total)
  static ({int baseScore, int timeBonus, int total}) calculateTotalScore({
    required int letterCount,
    required bool jokerUsed,
    required int timeRemaining,
  }) {
    final baseScore = calculateWordScore(
      letterCount: letterCount,
      jokerUsed: jokerUsed,
    );

    final timeBonus = calculateTimeBonus(timeRemaining, baseScore);

    return (
      baseScore: baseScore,
      timeBonus: timeBonus,
      total: baseScore + timeBonus,
    );
  }

  /// Kelime puanı ile birlikte detaylı breakdown döner.
  ///
  /// UI'da puan detayını göstermek için kullanılır.
  static ({
    int normalLetterCount,
    int normalLetterScore,
    bool hasJoker,
    int jokerScoreValue,
    bool isFullWordBonus,
    int baseScore,
  }) getScoreBreakdown({
    required int letterCount,
    required bool jokerUsed,
  }) {
    if (letterCount < minWordLength) {
      return (
        normalLetterCount: 0,
        normalLetterScore: 0,
        hasJoker: false,
        jokerScoreValue: 0,
        isFullWordBonus: false,
        baseScore: 0,
      );
    }

    final isFullBonus = isFullWord(letterCount, jokerUsed);

    if (isFullBonus) {
      return (
        normalLetterCount: letterCount - 1,
        normalLetterScore: 0, // Bonus durumunda ayrı hesaplanmaz
        hasJoker: true,
        jokerScoreValue: 0, // Bonus durumunda ayrı hesaplanmaz
        isFullWordBonus: true,
        baseScore: fullWordBonus,
      );
    }

    final normalLetters = jokerUsed ? letterCount - 1 : letterCount;
    final normalScore = normalLetters * letterScore;
    final jokerValue = jokerUsed ? jokerScore : 0;

    return (
      normalLetterCount: normalLetters,
      normalLetterScore: normalScore,
      hasJoker: jokerUsed,
      jokerScoreValue: jokerValue,
      isFullWordBonus: false,
      baseScore: normalScore + jokerValue,
    );
  }
}
