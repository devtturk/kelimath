// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameStatistics _$GameStatisticsFromJson(Map<String, dynamic> json) =>
    _GameStatistics(
      totalGamesPlayed: (json['totalGamesPlayed'] as num).toInt(),
      totalScore: (json['totalScore'] as num).toInt(),
      highScore: (json['highScore'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      lastPlayedDate: json['lastPlayedDate'] == null
          ? null
          : DateTime.parse(json['lastPlayedDate'] as String),
      wordStats: WordGameStats.fromJson(
        json['wordStats'] as Map<String, dynamic>,
      ),
      numberStats: NumberGameStats.fromJson(
        json['numberStats'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$GameStatisticsToJson(_GameStatistics instance) =>
    <String, dynamic>{
      'totalGamesPlayed': instance.totalGamesPlayed,
      'totalScore': instance.totalScore,
      'highScore': instance.highScore,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastPlayedDate': instance.lastPlayedDate?.toIso8601String(),
      'wordStats': instance.wordStats,
      'numberStats': instance.numberStats,
    };
