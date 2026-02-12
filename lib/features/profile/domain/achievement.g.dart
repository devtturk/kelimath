// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Achievement _$AchievementFromJson(Map<String, dynamic> json) => _Achievement(
  type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
  titleTr: json['titleTr'] as String,
  descriptionTr: json['descriptionTr'] as String,
  iconName: json['iconName'] as String,
  requiredValue: (json['requiredValue'] as num).toInt(),
  isUnlocked: json['isUnlocked'] as bool,
  unlockedAt: json['unlockedAt'] == null
      ? null
      : DateTime.parse(json['unlockedAt'] as String),
  currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AchievementToJson(_Achievement instance) =>
    <String, dynamic>{
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'titleTr': instance.titleTr,
      'descriptionTr': instance.descriptionTr,
      'iconName': instance.iconName,
      'requiredValue': instance.requiredValue,
      'isUnlocked': instance.isUnlocked,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'currentProgress': instance.currentProgress,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.firstWin: 'firstWin',
  AchievementType.tenGames: 'tenGames',
  AchievementType.fiftyGames: 'fiftyGames',
  AchievementType.hundredGames: 'hundredGames',
  AchievementType.perfectWord: 'perfectWord',
  AchievementType.perfectNumber: 'perfectNumber',
  AchievementType.streakThree: 'streakThree',
  AchievementType.streakSeven: 'streakSeven',
  AchievementType.streakThirty: 'streakThirty',
  AchievementType.wordMaster: 'wordMaster',
  AchievementType.numberMaster: 'numberMaster',
  AchievementType.speedDemon: 'speedDemon',
};
