import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_game_stats.freezed.dart';
part 'number_game_stats.g.dart';

/// Sayı oyunu istatistikleri.
@freezed
abstract class NumberGameStats with _$NumberGameStats {
  const NumberGameStats._();

  const factory NumberGameStats({
    /// Oynanan oyun sayısı.
    required int gamesPlayed,

    /// Toplam kazanılan puan.
    required int totalScore,

    /// En yüksek tek oyun puanı.
    required int highScore,

    /// Hedefe tam ulaşma sayısı.
    required int exactMatchCount,

    /// Ortalama hedeften uzaklık.
    required int averageDistance,

    /// En az işlem adımı ile çözüm.
    required int fewestSteps,

    /// Mükemmel round sayısı (tam + bonus).
    required int perfectRounds,

    /// İşlem adımı dağılımı (adım sayısı -> oyun sayısı).
    @Default({}) Map<String, int> stepDistribution,
  }) = _NumberGameStats;

  /// Ortalama puan.
  double get averageScore => gamesPlayed > 0 ? totalScore / gamesPlayed : 0;

  /// Tam isabet oranı.
  double get exactMatchRate =>
      gamesPlayed > 0 ? exactMatchCount / gamesPlayed : 0;

  /// Boş istatistikler.
  factory NumberGameStats.empty() => const NumberGameStats(
        gamesPlayed: 0,
        totalScore: 0,
        highScore: 0,
        exactMatchCount: 0,
        averageDistance: 0,
        fewestSteps: 0,
        perfectRounds: 0,
        stepDistribution: {},
      );

  factory NumberGameStats.fromJson(Map<String, dynamic> json) =>
      _$NumberGameStatsFromJson(json);
}
