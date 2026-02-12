// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_game_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordGameStats _$WordGameStatsFromJson(Map<String, dynamic> json) =>
    _WordGameStats(
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      totalScore: (json['totalScore'] as num).toInt(),
      highScore: (json['highScore'] as num).toInt(),
      totalWordsFound: (json['totalWordsFound'] as num).toInt(),
      longestWord: (json['longestWord'] as num).toInt(),
      bestWord: json['bestWord'] as String,
      fullWordBonusCount: (json['fullWordBonusCount'] as num).toInt(),
      perfectRounds: (json['perfectRounds'] as num).toInt(),
      wordLengthDistribution:
          (json['wordLengthDistribution'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$WordGameStatsToJson(_WordGameStats instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'totalScore': instance.totalScore,
      'highScore': instance.highScore,
      'totalWordsFound': instance.totalWordsFound,
      'longestWord': instance.longestWord,
      'bestWord': instance.bestWord,
      'fullWordBonusCount': instance.fullWordBonusCount,
      'perfectRounds': instance.perfectRounds,
      'wordLengthDistribution': instance.wordLengthDistribution,
    };
