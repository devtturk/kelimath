import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_history_entry.freezed.dart';
part 'game_history_entry.g.dart';

/// Oyun geçmişi girişi.
@freezed
abstract class GameHistoryEntry with _$GameHistoryEntry {
  const GameHistoryEntry._();

  const factory GameHistoryEntry({
    required String id,
    required DateTime playedAt,
    required int totalScore,
    required List<RoundResult> rounds,
    @Default(0) int totalDurationMs,
  }) = _GameHistoryEntry;

  /// Kelime turları puanı.
  int get wordRoundScore => rounds
      .where((r) => r.isWordGame)
      .fold(0, (sum, r) => sum + r.score + r.timeBonus);

  /// Sayı turları puanı.
  int get numberRoundScore => rounds
      .where((r) => !r.isWordGame)
      .fold(0, (sum, r) => sum + r.score + r.timeBonus);

  /// Toplam süre.
  Duration get totalDuration => Duration(milliseconds: totalDurationMs);

  factory GameHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$GameHistoryEntryFromJson(json);
}

/// Tur sonucu.
@freezed
abstract class RoundResult with _$RoundResult {
  const factory RoundResult({
    required bool isWordGame,
    required int score,
    required int timeBonus,
    String? userAnswer,
    String? bestAnswer,
  }) = _RoundResult;

  factory RoundResult.fromJson(Map<String, dynamic> json) =>
      _$RoundResultFromJson(json);
}
