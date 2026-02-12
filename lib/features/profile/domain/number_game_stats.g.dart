// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_game_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NumberGameStats _$NumberGameStatsFromJson(Map<String, dynamic> json) =>
    _NumberGameStats(
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      totalScore: (json['totalScore'] as num).toInt(),
      highScore: (json['highScore'] as num).toInt(),
      exactMatchCount: (json['exactMatchCount'] as num).toInt(),
      averageDistance: (json['averageDistance'] as num).toInt(),
      fewestSteps: (json['fewestSteps'] as num).toInt(),
      perfectRounds: (json['perfectRounds'] as num).toInt(),
      stepDistribution:
          (json['stepDistribution'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$NumberGameStatsToJson(_NumberGameStats instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'totalScore': instance.totalScore,
      'highScore': instance.highScore,
      'exactMatchCount': instance.exactMatchCount,
      'averageDistance': instance.averageDistance,
      'fewestSteps': instance.fewestSteps,
      'perfectRounds': instance.perfectRounds,
      'stepDistribution': instance.stepDistribution,
    };
