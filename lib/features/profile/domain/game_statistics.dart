import 'package:freezed_annotation/freezed_annotation.dart';

import 'word_game_stats.dart';
import 'number_game_stats.dart';

part 'game_statistics.freezed.dart';
part 'game_statistics.g.dart';

/// Genel oyun istatistikleri.
@freezed
abstract class GameStatistics with _$GameStatistics {
  const GameStatistics._();

  const factory GameStatistics({
    /// Toplam oynanan oyun sayısı.
    required int totalGamesPlayed,

    /// Toplam kazanılan puan.
    required int totalScore,

    /// En yüksek tek oyun puanı.
    required int highScore,

    /// Mevcut günlük seri.
    required int currentStreak,

    /// En uzun günlük seri.
    required int longestStreak,

    /// Son oynama tarihi.
    DateTime? lastPlayedDate,

    /// Kelime oyunu istatistikleri.
    required WordGameStats wordStats,

    /// Sayı oyunu istatistikleri.
    required NumberGameStats numberStats,
  }) = _GameStatistics;

  /// Ortalama puan.
  double get averageScore =>
      totalGamesPlayed > 0 ? totalScore / totalGamesPlayed : 0;

  /// Boş istatistikler.
  factory GameStatistics.empty() => GameStatistics(
        totalGamesPlayed: 0,
        totalScore: 0,
        highScore: 0,
        currentStreak: 0,
        longestStreak: 0,
        lastPlayedDate: null,
        wordStats: WordGameStats.empty(),
        numberStats: NumberGameStats.empty(),
      );

  factory GameStatistics.fromJson(Map<String, dynamic> json) =>
      _$GameStatisticsFromJson(json);
}
