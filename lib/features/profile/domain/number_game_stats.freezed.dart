// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_game_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NumberGameStats {

/// Oynanan oyun sayısı.
 int get gamesPlayed;/// Toplam kazanılan puan.
 int get totalScore;/// En yüksek tek oyun puanı.
 int get highScore;/// Hedefe tam ulaşma sayısı.
 int get exactMatchCount;/// Ortalama hedeften uzaklık.
 int get averageDistance;/// En az işlem adımı ile çözüm.
 int get fewestSteps;/// Mükemmel round sayısı (tam + bonus).
 int get perfectRounds;/// İşlem adımı dağılımı (adım sayısı -> oyun sayısı).
 Map<String, int> get stepDistribution;
/// Create a copy of NumberGameStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberGameStatsCopyWith<NumberGameStats> get copyWith => _$NumberGameStatsCopyWithImpl<NumberGameStats>(this as NumberGameStats, _$identity);

  /// Serializes this NumberGameStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberGameStats&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.exactMatchCount, exactMatchCount) || other.exactMatchCount == exactMatchCount)&&(identical(other.averageDistance, averageDistance) || other.averageDistance == averageDistance)&&(identical(other.fewestSteps, fewestSteps) || other.fewestSteps == fewestSteps)&&(identical(other.perfectRounds, perfectRounds) || other.perfectRounds == perfectRounds)&&const DeepCollectionEquality().equals(other.stepDistribution, stepDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesPlayed,totalScore,highScore,exactMatchCount,averageDistance,fewestSteps,perfectRounds,const DeepCollectionEquality().hash(stepDistribution));

@override
String toString() {
  return 'NumberGameStats(gamesPlayed: $gamesPlayed, totalScore: $totalScore, highScore: $highScore, exactMatchCount: $exactMatchCount, averageDistance: $averageDistance, fewestSteps: $fewestSteps, perfectRounds: $perfectRounds, stepDistribution: $stepDistribution)';
}


}

/// @nodoc
abstract mixin class $NumberGameStatsCopyWith<$Res>  {
  factory $NumberGameStatsCopyWith(NumberGameStats value, $Res Function(NumberGameStats) _then) = _$NumberGameStatsCopyWithImpl;
@useResult
$Res call({
 int gamesPlayed, int totalScore, int highScore, int exactMatchCount, int averageDistance, int fewestSteps, int perfectRounds, Map<String, int> stepDistribution
});




}
/// @nodoc
class _$NumberGameStatsCopyWithImpl<$Res>
    implements $NumberGameStatsCopyWith<$Res> {
  _$NumberGameStatsCopyWithImpl(this._self, this._then);

  final NumberGameStats _self;
  final $Res Function(NumberGameStats) _then;

/// Create a copy of NumberGameStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gamesPlayed = null,Object? totalScore = null,Object? highScore = null,Object? exactMatchCount = null,Object? averageDistance = null,Object? fewestSteps = null,Object? perfectRounds = null,Object? stepDistribution = null,}) {
  return _then(_self.copyWith(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,exactMatchCount: null == exactMatchCount ? _self.exactMatchCount : exactMatchCount // ignore: cast_nullable_to_non_nullable
as int,averageDistance: null == averageDistance ? _self.averageDistance : averageDistance // ignore: cast_nullable_to_non_nullable
as int,fewestSteps: null == fewestSteps ? _self.fewestSteps : fewestSteps // ignore: cast_nullable_to_non_nullable
as int,perfectRounds: null == perfectRounds ? _self.perfectRounds : perfectRounds // ignore: cast_nullable_to_non_nullable
as int,stepDistribution: null == stepDistribution ? _self.stepDistribution : stepDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberGameStats].
extension NumberGameStatsPatterns on NumberGameStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberGameStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberGameStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberGameStats value)  $default,){
final _that = this;
switch (_that) {
case _NumberGameStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberGameStats value)?  $default,){
final _that = this;
switch (_that) {
case _NumberGameStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gamesPlayed,  int totalScore,  int highScore,  int exactMatchCount,  int averageDistance,  int fewestSteps,  int perfectRounds,  Map<String, int> stepDistribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberGameStats() when $default != null:
return $default(_that.gamesPlayed,_that.totalScore,_that.highScore,_that.exactMatchCount,_that.averageDistance,_that.fewestSteps,_that.perfectRounds,_that.stepDistribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gamesPlayed,  int totalScore,  int highScore,  int exactMatchCount,  int averageDistance,  int fewestSteps,  int perfectRounds,  Map<String, int> stepDistribution)  $default,) {final _that = this;
switch (_that) {
case _NumberGameStats():
return $default(_that.gamesPlayed,_that.totalScore,_that.highScore,_that.exactMatchCount,_that.averageDistance,_that.fewestSteps,_that.perfectRounds,_that.stepDistribution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gamesPlayed,  int totalScore,  int highScore,  int exactMatchCount,  int averageDistance,  int fewestSteps,  int perfectRounds,  Map<String, int> stepDistribution)?  $default,) {final _that = this;
switch (_that) {
case _NumberGameStats() when $default != null:
return $default(_that.gamesPlayed,_that.totalScore,_that.highScore,_that.exactMatchCount,_that.averageDistance,_that.fewestSteps,_that.perfectRounds,_that.stepDistribution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NumberGameStats extends NumberGameStats {
  const _NumberGameStats({required this.gamesPlayed, required this.totalScore, required this.highScore, required this.exactMatchCount, required this.averageDistance, required this.fewestSteps, required this.perfectRounds, final  Map<String, int> stepDistribution = const {}}): _stepDistribution = stepDistribution,super._();
  factory _NumberGameStats.fromJson(Map<String, dynamic> json) => _$NumberGameStatsFromJson(json);

/// Oynanan oyun sayısı.
@override final  int gamesPlayed;
/// Toplam kazanılan puan.
@override final  int totalScore;
/// En yüksek tek oyun puanı.
@override final  int highScore;
/// Hedefe tam ulaşma sayısı.
@override final  int exactMatchCount;
/// Ortalama hedeften uzaklık.
@override final  int averageDistance;
/// En az işlem adımı ile çözüm.
@override final  int fewestSteps;
/// Mükemmel round sayısı (tam + bonus).
@override final  int perfectRounds;
/// İşlem adımı dağılımı (adım sayısı -> oyun sayısı).
 final  Map<String, int> _stepDistribution;
/// İşlem adımı dağılımı (adım sayısı -> oyun sayısı).
@override@JsonKey() Map<String, int> get stepDistribution {
  if (_stepDistribution is EqualUnmodifiableMapView) return _stepDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stepDistribution);
}


/// Create a copy of NumberGameStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberGameStatsCopyWith<_NumberGameStats> get copyWith => __$NumberGameStatsCopyWithImpl<_NumberGameStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NumberGameStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberGameStats&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.exactMatchCount, exactMatchCount) || other.exactMatchCount == exactMatchCount)&&(identical(other.averageDistance, averageDistance) || other.averageDistance == averageDistance)&&(identical(other.fewestSteps, fewestSteps) || other.fewestSteps == fewestSteps)&&(identical(other.perfectRounds, perfectRounds) || other.perfectRounds == perfectRounds)&&const DeepCollectionEquality().equals(other._stepDistribution, _stepDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesPlayed,totalScore,highScore,exactMatchCount,averageDistance,fewestSteps,perfectRounds,const DeepCollectionEquality().hash(_stepDistribution));

@override
String toString() {
  return 'NumberGameStats(gamesPlayed: $gamesPlayed, totalScore: $totalScore, highScore: $highScore, exactMatchCount: $exactMatchCount, averageDistance: $averageDistance, fewestSteps: $fewestSteps, perfectRounds: $perfectRounds, stepDistribution: $stepDistribution)';
}


}

/// @nodoc
abstract mixin class _$NumberGameStatsCopyWith<$Res> implements $NumberGameStatsCopyWith<$Res> {
  factory _$NumberGameStatsCopyWith(_NumberGameStats value, $Res Function(_NumberGameStats) _then) = __$NumberGameStatsCopyWithImpl;
@override @useResult
$Res call({
 int gamesPlayed, int totalScore, int highScore, int exactMatchCount, int averageDistance, int fewestSteps, int perfectRounds, Map<String, int> stepDistribution
});




}
/// @nodoc
class __$NumberGameStatsCopyWithImpl<$Res>
    implements _$NumberGameStatsCopyWith<$Res> {
  __$NumberGameStatsCopyWithImpl(this._self, this._then);

  final _NumberGameStats _self;
  final $Res Function(_NumberGameStats) _then;

/// Create a copy of NumberGameStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gamesPlayed = null,Object? totalScore = null,Object? highScore = null,Object? exactMatchCount = null,Object? averageDistance = null,Object? fewestSteps = null,Object? perfectRounds = null,Object? stepDistribution = null,}) {
  return _then(_NumberGameStats(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,exactMatchCount: null == exactMatchCount ? _self.exactMatchCount : exactMatchCount // ignore: cast_nullable_to_non_nullable
as int,averageDistance: null == averageDistance ? _self.averageDistance : averageDistance // ignore: cast_nullable_to_non_nullable
as int,fewestSteps: null == fewestSteps ? _self.fewestSteps : fewestSteps // ignore: cast_nullable_to_non_nullable
as int,perfectRounds: null == perfectRounds ? _self.perfectRounds : perfectRounds // ignore: cast_nullable_to_non_nullable
as int,stepDistribution: null == stepDistribution ? _self._stepDistribution : stepDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
