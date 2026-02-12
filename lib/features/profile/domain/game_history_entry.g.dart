// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameHistoryEntry _$GameHistoryEntryFromJson(Map<String, dynamic> json) =>
    _GameHistoryEntry(
      id: json['id'] as String,
      playedAt: DateTime.parse(json['playedAt'] as String),
      totalScore: (json['totalScore'] as num).toInt(),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => RoundResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDurationMs: (json['totalDurationMs'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GameHistoryEntryToJson(_GameHistoryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playedAt': instance.playedAt.toIso8601String(),
      'totalScore': instance.totalScore,
      'rounds': instance.rounds,
      'totalDurationMs': instance.totalDurationMs,
    };

_RoundResult _$RoundResultFromJson(Map<String, dynamic> json) => _RoundResult(
  isWordGame: json['isWordGame'] as bool,
  score: (json['score'] as num).toInt(),
  timeBonus: (json['timeBonus'] as num).toInt(),
  userAnswer: json['userAnswer'] as String?,
  bestAnswer: json['bestAnswer'] as String?,
);

Map<String, dynamic> _$RoundResultToJson(_RoundResult instance) =>
    <String, dynamic>{
      'isWordGame': instance.isWordGame,
      'score': instance.score,
      'timeBonus': instance.timeBonus,
      'userAnswer': instance.userAnswer,
      'bestAnswer': instance.bestAnswer,
    };
