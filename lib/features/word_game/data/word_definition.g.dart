// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordDefinition _$WordDefinitionFromJson(Map<String, dynamic> json) =>
    _WordDefinition(
      word: json['word'] as String,
      meanings: (json['meanings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      origin: json['origin'] as String?,
      examples:
          (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      cachedAt: json['cachedAt'] == null
          ? null
          : DateTime.parse(json['cachedAt'] as String),
    );

Map<String, dynamic> _$WordDefinitionToJson(_WordDefinition instance) =>
    <String, dynamic>{
      'word': instance.word,
      'meanings': instance.meanings,
      'origin': instance.origin,
      'examples': instance.examples,
      'cachedAt': instance.cachedAt?.toIso8601String(),
    };
