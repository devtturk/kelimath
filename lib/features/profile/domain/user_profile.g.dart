// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  avatarId: (json['avatarId'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastPlayedAt: json['lastPlayedAt'] == null
      ? null
      : DateTime.parse(json['lastPlayedAt'] as String),
  locale: json['locale'] as String? ?? 'tr',
  hasCompletedTutorial: json['hasCompletedTutorial'] as bool? ?? false,
  tutorialCompletedAt: json['tutorialCompletedAt'] == null
      ? null
      : DateTime.parse(json['tutorialCompletedAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'avatarId': instance.avatarId,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastPlayedAt': instance.lastPlayedAt?.toIso8601String(),
      'locale': instance.locale,
      'hasCompletedTutorial': instance.hasCompletedTutorial,
      'tutorialCompletedAt': instance.tutorialCompletedAt?.toIso8601String(),
    };
