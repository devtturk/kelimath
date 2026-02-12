// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordDefinition {

/// Kelime.
 String get word;/// Kelimenin anlamları listesi.
 List<String> get meanings;/// Kelimenin kökeni/etimolojisi (opsiyonel).
 String? get origin;/// Örnek cümleler (opsiyonel).
 List<String> get examples;/// Cache'lenme tarihi.
 DateTime? get cachedAt;
/// Create a copy of WordDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordDefinitionCopyWith<WordDefinition> get copyWith => _$WordDefinitionCopyWithImpl<WordDefinition>(this as WordDefinition, _$identity);

  /// Serializes this WordDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordDefinition&&(identical(other.word, word) || other.word == word)&&const DeepCollectionEquality().equals(other.meanings, meanings)&&(identical(other.origin, origin) || other.origin == origin)&&const DeepCollectionEquality().equals(other.examples, examples)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,word,const DeepCollectionEquality().hash(meanings),origin,const DeepCollectionEquality().hash(examples),cachedAt);

@override
String toString() {
  return 'WordDefinition(word: $word, meanings: $meanings, origin: $origin, examples: $examples, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class $WordDefinitionCopyWith<$Res>  {
  factory $WordDefinitionCopyWith(WordDefinition value, $Res Function(WordDefinition) _then) = _$WordDefinitionCopyWithImpl;
@useResult
$Res call({
 String word, List<String> meanings, String? origin, List<String> examples, DateTime? cachedAt
});




}
/// @nodoc
class _$WordDefinitionCopyWithImpl<$Res>
    implements $WordDefinitionCopyWith<$Res> {
  _$WordDefinitionCopyWithImpl(this._self, this._then);

  final WordDefinition _self;
  final $Res Function(WordDefinition) _then;

/// Create a copy of WordDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? meanings = null,Object? origin = freezed,Object? examples = null,Object? cachedAt = freezed,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,meanings: null == meanings ? _self.meanings : meanings // ignore: cast_nullable_to_non_nullable
as List<String>,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<String>,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordDefinition].
extension WordDefinitionPatterns on WordDefinition {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordDefinition() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordDefinition value)  $default,){
final _that = this;
switch (_that) {
case _WordDefinition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _WordDefinition() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  List<String> meanings,  String? origin,  List<String> examples,  DateTime? cachedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordDefinition() when $default != null:
return $default(_that.word,_that.meanings,_that.origin,_that.examples,_that.cachedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  List<String> meanings,  String? origin,  List<String> examples,  DateTime? cachedAt)  $default,) {final _that = this;
switch (_that) {
case _WordDefinition():
return $default(_that.word,_that.meanings,_that.origin,_that.examples,_that.cachedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  List<String> meanings,  String? origin,  List<String> examples,  DateTime? cachedAt)?  $default,) {final _that = this;
switch (_that) {
case _WordDefinition() when $default != null:
return $default(_that.word,_that.meanings,_that.origin,_that.examples,_that.cachedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordDefinition extends WordDefinition {
  const _WordDefinition({required this.word, required final  List<String> meanings, this.origin, final  List<String> examples = const [], this.cachedAt}): _meanings = meanings,_examples = examples,super._();
  factory _WordDefinition.fromJson(Map<String, dynamic> json) => _$WordDefinitionFromJson(json);

/// Kelime.
@override final  String word;
/// Kelimenin anlamları listesi.
 final  List<String> _meanings;
/// Kelimenin anlamları listesi.
@override List<String> get meanings {
  if (_meanings is EqualUnmodifiableListView) return _meanings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meanings);
}

/// Kelimenin kökeni/etimolojisi (opsiyonel).
@override final  String? origin;
/// Örnek cümleler (opsiyonel).
 final  List<String> _examples;
/// Örnek cümleler (opsiyonel).
@override@JsonKey() List<String> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}

/// Cache'lenme tarihi.
@override final  DateTime? cachedAt;

/// Create a copy of WordDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordDefinitionCopyWith<_WordDefinition> get copyWith => __$WordDefinitionCopyWithImpl<_WordDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordDefinition&&(identical(other.word, word) || other.word == word)&&const DeepCollectionEquality().equals(other._meanings, _meanings)&&(identical(other.origin, origin) || other.origin == origin)&&const DeepCollectionEquality().equals(other._examples, _examples)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,word,const DeepCollectionEquality().hash(_meanings),origin,const DeepCollectionEquality().hash(_examples),cachedAt);

@override
String toString() {
  return 'WordDefinition(word: $word, meanings: $meanings, origin: $origin, examples: $examples, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class _$WordDefinitionCopyWith<$Res> implements $WordDefinitionCopyWith<$Res> {
  factory _$WordDefinitionCopyWith(_WordDefinition value, $Res Function(_WordDefinition) _then) = __$WordDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String word, List<String> meanings, String? origin, List<String> examples, DateTime? cachedAt
});




}
/// @nodoc
class __$WordDefinitionCopyWithImpl<$Res>
    implements _$WordDefinitionCopyWith<$Res> {
  __$WordDefinitionCopyWithImpl(this._self, this._then);

  final _WordDefinition _self;
  final $Res Function(_WordDefinition) _then;

/// Create a copy of WordDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? meanings = null,Object? origin = freezed,Object? examples = null,Object? cachedAt = freezed,}) {
  return _then(_WordDefinition(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,meanings: null == meanings ? _self._meanings : meanings // ignore: cast_nullable_to_non_nullable
as List<String>,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<String>,cachedAt: freezed == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
