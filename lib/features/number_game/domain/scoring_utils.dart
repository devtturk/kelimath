/// Sayı oyunu puanlama yardımcı fonksiyonları.
///
/// gamemechanics.md'ye göre puanlama tablosu:
/// - 0 fark = 100 puan
/// - 1 fark = 90 puan
/// - 2 fark = 80 puan
/// - ...
/// - 9 fark = 10 puan
/// - 10+ fark = 0 puan
///
/// Time Bonus = Kalan Saniye × 1 (sadece puan > 0 ise)
abstract final class ScoringUtils {
  /// Maksimum geçerli mesafe. Bu değerin üzerinde puan 0'dır.
  static const int maxValidDistance = 10;

  /// Tam eşleşme puanı.
  static const int exactMatchScore = 100;

  /// Her mesafe birimi için düşen puan.
  static const int pointsPerDistance = 10;

  /// Tur süresi (saniye). 1 dakika 30 saniye = 90 saniye.
  static const int roundDuration = 90;

  /// Hedefe olan mesafeye göre işlem puanını hesaplar.
  ///
  /// [distance]: Hedef ile bulunan sayı arasındaki mutlak fark.
  ///
  /// Returns: 0-100 arası puan.
  static int calculateBaseScore(int distance) {
    if (distance < 0) {
      throw ArgumentError('Distance cannot be negative');
    }

    if (distance >= maxValidDistance) {
      return 0;
    }

    return exactMatchScore - (distance * pointsPerDistance);
  }

  /// Zaman bonusunu hesaplar.
  ///
  /// [timeRemaining]: Kalan süre (saniye).
  /// [baseScore]: İşlem puanı. 0 ise zaman bonusu da 0'dır.
  ///
  /// Returns: Zaman bonusu puanı.
  static int calculateTimeBonus(int timeRemaining, int baseScore) {
    if (timeRemaining < 0) {
      return 0;
    }

    // Sadece geçerli bir puan varsa zaman bonusu verilir.
    if (baseScore <= 0) {
      return 0;
    }

    return timeRemaining;
  }

  /// Toplam puanı hesaplar.
  ///
  /// [distance]: Hedef ile bulunan sayı arasındaki mutlak fark.
  /// [timeRemaining]: Kalan süre (saniye).
  ///
  /// Returns: (baseScore, timeBonus, totalScore) tuple'ı.
  static ({int baseScore, int timeBonus, int totalScore}) calculateTotalScore({
    required int distance,
    required int timeRemaining,
  }) {
    final baseScore = calculateBaseScore(distance);
    final timeBonus = calculateTimeBonus(timeRemaining, baseScore);
    final totalScore = baseScore + timeBonus;

    return (
      baseScore: baseScore,
      timeBonus: timeBonus,
      totalScore: totalScore,
    );
  }

  /// Mesafe tablosunu döndürür (UI gösterimi için).
  static Map<int, int> get scoreTable {
    return {
      for (int i = 0; i < maxValidDistance; i++) i: exactMatchScore - (i * pointsPerDistance),
    };
  }
}
