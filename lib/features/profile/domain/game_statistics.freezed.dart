// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameStatistics {

/// Toplam oynanan oyun sayısı.
 int get totalGamesPlayed;/// Toplam kazanılan puan.
 int get totalScore;/// En yüksek tek oyun puanı.
 int get highScore;/// Mevcut günlük seri.
 int get currentStreak;/// En uzun günlük seri.
 int get longestStreak;/// Son oynama tarihi.
 DateTime? get lastPlayedDate;/// Kelime oyunu istatistikleri.
 WordGameStats get wordStats;/// Sayı oyunu istatistikleri.
 NumberGameStats get numberStats;
/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStatisticsCopyWith<GameStatistics> get copyWith => _$GameStatisticsCopyWithImpl<GameStatistics>(this as GameStatistics, _$identity);

  /// Serializes this GameStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStatistics&&(identical(other.totalGamesPlayed, totalGamesPlayed) || other.totalGamesPlayed == totalGamesPlayed)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastPlayedDate, lastPlayedDate) || other.lastPlayedDate == lastPlayedDate)&&(identical(other.wordStats, wordStats) || other.wordStats == wordStats)&&(identical(other.numberStats, numberStats) || other.numberStats == numberStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalGamesPlayed,totalScore,highScore,currentStreak,longestStreak,lastPlayedDate,wordStats,numberStats);

@override
String toString() {
  return 'GameStatistics(totalGamesPlayed: $totalGamesPlayed, totalScore: $totalScore, highScore: $highScore, currentStreak: $currentStreak, longestStreak: $longestStreak, lastPlayedDate: $lastPlayedDate, wordStats: $wordStats, numberStats: $numberStats)';
}


}

/// @nodoc
abstract mixin class $GameStatisticsCopyWith<$Res>  {
  factory $GameStatisticsCopyWith(GameStatistics value, $Res Function(GameStatistics) _then) = _$GameStatisticsCopyWithImpl;
@useResult
$Res call({
 int totalGamesPlayed, int totalScore, int highScore, int currentStreak, int longestStreak, DateTime? lastPlayedDate, WordGameStats wordStats, NumberGameStats numberStats
});


$WordGameStatsCopyWith<$Res> get wordStats;$NumberGameStatsCopyWith<$Res> get numberStats;

}
/// @nodoc
class _$GameStatisticsCopyWithImpl<$Res>
    implements $GameStatisticsCopyWith<$Res> {
  _$GameStatisticsCopyWithImpl(this._self, this._then);

  final GameStatistics _self;
  final $Res Function(GameStatistics) _then;

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalGamesPlayed = null,Object? totalScore = null,Object? highScore = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastPlayedDate = freezed,Object? wordStats = null,Object? numberStats = null,}) {
  return _then(_self.copyWith(
totalGamesPlayed: null == totalGamesPlayed ? _self.totalGamesPlayed : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastPlayedDate: freezed == lastPlayedDate ? _self.lastPlayedDate : lastPlayedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,wordStats: null == wordStats ? _self.wordStats : wordStats // ignore: cast_nullable_to_non_nullable
as WordGameStats,numberStats: null == numberStats ? _self.numberStats : numberStats // ignore: cast_nullable_to_non_nullable
as NumberGameStats,
  ));
}
/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameStatsCopyWith<$Res> get wordStats {
  
  return $WordGameStatsCopyWith<$Res>(_self.wordStats, (value) {
    return _then(_self.copyWith(wordStats: value));
  });
}/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberGameStatsCopyWith<$Res> get numberStats {
  
  return $NumberGameStatsCopyWith<$Res>(_self.numberStats, (value) {
    return _then(_self.copyWith(numberStats: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameStatistics].
extension GameStatisticsPatterns on GameStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameStatistics value)  $default,){
final _that = this;
switch (_that) {
case _GameStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalGamesPlayed,  int totalScore,  int highScore,  int currentStreak,  int longestStreak,  DateTime? lastPlayedDate,  WordGameStats wordStats,  NumberGameStats numberStats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
return $default(_that.totalGamesPlayed,_that.totalScore,_that.highScore,_that.currentStreak,_that.longestStreak,_that.lastPlayedDate,_that.wordStats,_that.numberStats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalGamesPlayed,  int totalScore,  int highScore,  int currentStreak,  int longestStreak,  DateTime? lastPlayedDate,  WordGameStats wordStats,  NumberGameStats numberStats)  $default,) {final _that = this;
switch (_that) {
case _GameStatistics():
return $default(_that.totalGamesPlayed,_that.totalScore,_that.highScore,_that.currentStreak,_that.longestStreak,_that.lastPlayedDate,_that.wordStats,_that.numberStats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalGamesPlayed,  int totalScore,  int highScore,  int currentStreak,  int longestStreak,  DateTime? lastPlayedDate,  WordGameStats wordStats,  NumberGameStats numberStats)?  $default,) {final _that = this;
switch (_that) {
case _GameStatistics() when $default != null:
return $default(_that.totalGamesPlayed,_that.totalScore,_that.highScore,_that.currentStreak,_that.longestStreak,_that.lastPlayedDate,_that.wordStats,_that.numberStats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameStatistics extends GameStatistics {
  const _GameStatistics({required this.totalGamesPlayed, required this.totalScore, required this.highScore, required this.currentStreak, required this.longestStreak, this.lastPlayedDate, required this.wordStats, required this.numberStats}): super._();
  factory _GameStatistics.fromJson(Map<String, dynamic> json) => _$GameStatisticsFromJson(json);

/// Toplam oynanan oyun sayısı.
@override final  int totalGamesPlayed;
/// Toplam kazanılan puan.
@override final  int totalScore;
/// En yüksek tek oyun puanı.
@override final  int highScore;
/// Mevcut günlük seri.
@override final  int currentStreak;
/// En uzun günlük seri.
@override final  int longestStreak;
/// Son oynama tarihi.
@override final  DateTime? lastPlayedDate;
/// Kelime oyunu istatistikleri.
@override final  WordGameStats wordStats;
/// Sayı oyunu istatistikleri.
@override final  NumberGameStats numberStats;

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStatisticsCopyWith<_GameStatistics> get copyWith => __$GameStatisticsCopyWithImpl<_GameStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameStatistics&&(identical(other.totalGamesPlayed, totalGamesPlayed) || other.totalGamesPlayed == totalGamesPlayed)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastPlayedDate, lastPlayedDate) || other.lastPlayedDate == lastPlayedDate)&&(identical(other.wordStats, wordStats) || other.wordStats == wordStats)&&(identical(other.numberStats, numberStats) || other.numberStats == numberStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalGamesPlayed,totalScore,highScore,currentStreak,longestStreak,lastPlayedDate,wordStats,numberStats);

@override
String toString() {
  return 'GameStatistics(totalGamesPlayed: $totalGamesPlayed, totalScore: $totalScore, highScore: $highScore, currentStreak: $currentStreak, longestStreak: $longestStreak, lastPlayedDate: $lastPlayedDate, wordStats: $wordStats, numberStats: $numberStats)';
}


}

/// @nodoc
abstract mixin class _$GameStatisticsCopyWith<$Res> implements $GameStatisticsCopyWith<$Res> {
  factory _$GameStatisticsCopyWith(_GameStatistics value, $Res Function(_GameStatistics) _then) = __$GameStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int totalGamesPlayed, int totalScore, int highScore, int currentStreak, int longestStreak, DateTime? lastPlayedDate, WordGameStats wordStats, NumberGameStats numberStats
});


@override $WordGameStatsCopyWith<$Res> get wordStats;@override $NumberGameStatsCopyWith<$Res> get numberStats;

}
/// @nodoc
class __$GameStatisticsCopyWithImpl<$Res>
    implements _$GameStatisticsCopyWith<$Res> {
  __$GameStatisticsCopyWithImpl(this._self, this._then);

  final _GameStatistics _self;
  final $Res Function(_GameStatistics) _then;

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalGamesPlayed = null,Object? totalScore = null,Object? highScore = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastPlayedDate = freezed,Object? wordStats = null,Object? numberStats = null,}) {
  return _then(_GameStatistics(
totalGamesPlayed: null == totalGamesPlayed ? _self.totalGamesPlayed : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastPlayedDate: freezed == lastPlayedDate ? _self.lastPlayedDate : lastPlayedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,wordStats: null == wordStats ? _self.wordStats : wordStats // ignore: cast_nullable_to_non_nullable
as WordGameStats,numberStats: null == numberStats ? _self.numberStats : numberStats // ignore: cast_nullable_to_non_nullable
as NumberGameStats,
  ));
}

/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordGameStatsCopyWith<$Res> get wordStats {
  
  return $WordGameStatsCopyWith<$Res>(_self.wordStats, (value) {
    return _then(_self.copyWith(wordStats: value));
  });
}/// Create a copy of GameStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NumberGameStatsCopyWith<$Res> get numberStats {
  
  return $NumberGameStatsCopyWith<$Res>(_self.numberStats, (value) {
    return _then(_self.copyWith(numberStats: value));
  });
}
}

// dart format on
