// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get id; String get displayName; int get avatarId; DateTime get createdAt; DateTime? get lastPlayedAt; String get locale;/// Tutorial tamamlandı mı?
 bool get hasCompletedTutorial;/// Tutorial tamamlanma tarihi.
 DateTime? get tutorialCompletedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.hasCompletedTutorial, hasCompletedTutorial) || other.hasCompletedTutorial == hasCompletedTutorial)&&(identical(other.tutorialCompletedAt, tutorialCompletedAt) || other.tutorialCompletedAt == tutorialCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,avatarId,createdAt,lastPlayedAt,locale,hasCompletedTutorial,tutorialCompletedAt);

@override
String toString() {
  return 'UserProfile(id: $id, displayName: $displayName, avatarId: $avatarId, createdAt: $createdAt, lastPlayedAt: $lastPlayedAt, locale: $locale, hasCompletedTutorial: $hasCompletedTutorial, tutorialCompletedAt: $tutorialCompletedAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, int avatarId, DateTime createdAt, DateTime? lastPlayedAt, String locale, bool hasCompletedTutorial, DateTime? tutorialCompletedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? avatarId = null,Object? createdAt = null,Object? lastPlayedAt = freezed,Object? locale = null,Object? hasCompletedTutorial = null,Object? tutorialCompletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,hasCompletedTutorial: null == hasCompletedTutorial ? _self.hasCompletedTutorial : hasCompletedTutorial // ignore: cast_nullable_to_non_nullable
as bool,tutorialCompletedAt: freezed == tutorialCompletedAt ? _self.tutorialCompletedAt : tutorialCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  int avatarId,  DateTime createdAt,  DateTime? lastPlayedAt,  String locale,  bool hasCompletedTutorial,  DateTime? tutorialCompletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.displayName,_that.avatarId,_that.createdAt,_that.lastPlayedAt,_that.locale,_that.hasCompletedTutorial,_that.tutorialCompletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  int avatarId,  DateTime createdAt,  DateTime? lastPlayedAt,  String locale,  bool hasCompletedTutorial,  DateTime? tutorialCompletedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.displayName,_that.avatarId,_that.createdAt,_that.lastPlayedAt,_that.locale,_that.hasCompletedTutorial,_that.tutorialCompletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  int avatarId,  DateTime createdAt,  DateTime? lastPlayedAt,  String locale,  bool hasCompletedTutorial,  DateTime? tutorialCompletedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.displayName,_that.avatarId,_that.createdAt,_that.lastPlayedAt,_that.locale,_that.hasCompletedTutorial,_that.tutorialCompletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.displayName, required this.avatarId, required this.createdAt, this.lastPlayedAt, this.locale = 'tr', this.hasCompletedTutorial = false, this.tutorialCompletedAt}): super._();
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  int avatarId;
@override final  DateTime createdAt;
@override final  DateTime? lastPlayedAt;
@override@JsonKey() final  String locale;
/// Tutorial tamamlandı mı?
@override@JsonKey() final  bool hasCompletedTutorial;
/// Tutorial tamamlanma tarihi.
@override final  DateTime? tutorialCompletedAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.hasCompletedTutorial, hasCompletedTutorial) || other.hasCompletedTutorial == hasCompletedTutorial)&&(identical(other.tutorialCompletedAt, tutorialCompletedAt) || other.tutorialCompletedAt == tutorialCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,avatarId,createdAt,lastPlayedAt,locale,hasCompletedTutorial,tutorialCompletedAt);

@override
String toString() {
  return 'UserProfile(id: $id, displayName: $displayName, avatarId: $avatarId, createdAt: $createdAt, lastPlayedAt: $lastPlayedAt, locale: $locale, hasCompletedTutorial: $hasCompletedTutorial, tutorialCompletedAt: $tutorialCompletedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, int avatarId, DateTime createdAt, DateTime? lastPlayedAt, String locale, bool hasCompletedTutorial, DateTime? tutorialCompletedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? avatarId = null,Object? createdAt = null,Object? lastPlayedAt = freezed,Object? locale = null,Object? hasCompletedTutorial = null,Object? tutorialCompletedAt = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,hasCompletedTutorial: null == hasCompletedTutorial ? _self.hasCompletedTutorial : hasCompletedTutorial // ignore: cast_nullable_to_non_nullable
as bool,tutorialCompletedAt: freezed == tutorialCompletedAt ? _self.tutorialCompletedAt : tutorialCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
