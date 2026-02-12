import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_game_stats.freezed.dart';
part 'word_game_stats.g.dart';

/// Kelime oyunu istatistikleri.
@freezed
abstract class WordGameStats with _$WordGameStats {
  const WordGameStats._();

  const factory WordGameStats({
    /// Oynanan oyun sayısı.
    required int gamesPlayed,

    /// Toplam kazanılan puan.
    required int totalScore,

    /// En yüksek tek oyun puanı.
    required int highScore,

    /// Toplam bulunan kelime sayısı.
    required int totalWordsFound,

    /// En uzun kelimenin harf sayısı.
    required int longestWord,

    /// En iyi bulunan kelime.
    required String bestWord,

    /// 9 harfli tam kelime bonusu sayısı.
    required int fullWordBonusCount,

    /// Mükemmel round sayısı (maksimum puan).
    required int perfectRounds,

    /// Kelime uzunluğu dağılımı (uzunluk -> sayı).
    @Default({}) Map<String, int> wordLengthDistribution,
  }) = _WordGameStats;

  /// Ortalama puan.
  double get averageScore => gamesPlayed > 0 ? totalScore / gamesPlayed : 0;

  /// Boş istatistikler.
  factory WordGameStats.empty() => const WordGameStats(
        gamesPlayed: 0,
        totalScore: 0,
        highScore: 0,
        totalWordsFound: 0,
        longestWord: 0,
        bestWord: '',
        fullWordBonusCount: 0,
        perfectRounds: 0,
        wordLengthDistribution: {},
      );

  factory WordGameStats.fromJson(Map<String, dynamic> json) =>
      _$WordGameStatsFromJson(json);
}
