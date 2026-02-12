// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameHistoryEntry {

 String get id; DateTime get playedAt; int get totalScore; List<RoundResult> get rounds; int get totalDurationMs;
/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryEntryCopyWith<GameHistoryEntry> get copyWith => _$GameHistoryEntryCopyWithImpl<GameHistoryEntry>(this as GameHistoryEntry, _$identity);

  /// Serializes this GameHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&const DeepCollectionEquality().equals(other.rounds, rounds)&&(identical(other.totalDurationMs, totalDurationMs) || other.totalDurationMs == totalDurationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playedAt,totalScore,const DeepCollectionEquality().hash(rounds),totalDurationMs);

@override
String toString() {
  return 'GameHistoryEntry(id: $id, playedAt: $playedAt, totalScore: $totalScore, rounds: $rounds, totalDurationMs: $totalDurationMs)';
}


}

/// @nodoc
abstract mixin class $GameHistoryEntryCopyWith<$Res>  {
  factory $GameHistoryEntryCopyWith(GameHistoryEntry value, $Res Function(GameHistoryEntry) _then) = _$GameHistoryEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime playedAt, int totalScore, List<RoundResult> rounds, int totalDurationMs
});




}
/// @nodoc
class _$GameHistoryEntryCopyWithImpl<$Res>
    implements $GameHistoryEntryCopyWith<$Res> {
  _$GameHistoryEntryCopyWithImpl(this._self, this._then);

  final GameHistoryEntry _self;
  final $Res Function(GameHistoryEntry) _then;

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? playedAt = null,Object? totalScore = null,Object? rounds = null,Object? totalDurationMs = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<RoundResult>,totalDurationMs: null == totalDurationMs ? _self.totalDurationMs : totalDurationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GameHistoryEntry].
extension GameHistoryEntryPatterns on GameHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _GameHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime playedAt,  int totalScore,  List<RoundResult> rounds,  int totalDurationMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
return $default(_that.id,_that.playedAt,_that.totalScore,_that.rounds,_that.totalDurationMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime playedAt,  int totalScore,  List<RoundResult> rounds,  int totalDurationMs)  $default,) {final _that = this;
switch (_that) {
case _GameHistoryEntry():
return $default(_that.id,_that.playedAt,_that.totalScore,_that.rounds,_that.totalDurationMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime playedAt,  int totalScore,  List<RoundResult> rounds,  int totalDurationMs)?  $default,) {final _that = this;
switch (_that) {
case _GameHistoryEntry() when $default != null:
return $default(_that.id,_that.playedAt,_that.totalScore,_that.rounds,_that.totalDurationMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameHistoryEntry extends GameHistoryEntry {
  const _GameHistoryEntry({required this.id, required this.playedAt, required this.totalScore, required final  List<RoundResult> rounds, this.totalDurationMs = 0}): _rounds = rounds,super._();
  factory _GameHistoryEntry.fromJson(Map<String, dynamic> json) => _$GameHistoryEntryFromJson(json);

@override final  String id;
@override final  DateTime playedAt;
@override final  int totalScore;
 final  List<RoundResult> _rounds;
@override List<RoundResult> get rounds {
  if (_rounds is EqualUnmodifiableListView) return _rounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rounds);
}

@override@JsonKey() final  int totalDurationMs;

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameHistoryEntryCopyWith<_GameHistoryEntry> get copyWith => __$GameHistoryEntryCopyWithImpl<_GameHistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameHistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.playedAt, playedAt) || other.playedAt == playedAt)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&const DeepCollectionEquality().equals(other._rounds, _rounds)&&(identical(other.totalDurationMs, totalDurationMs) || other.totalDurationMs == totalDurationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,playedAt,totalScore,const DeepCollectionEquality().hash(_rounds),totalDurationMs);

@override
String toString() {
  return 'GameHistoryEntry(id: $id, playedAt: $playedAt, totalScore: $totalScore, rounds: $rounds, totalDurationMs: $totalDurationMs)';
}


}

/// @nodoc
abstract mixin class _$GameHistoryEntryCopyWith<$Res> implements $GameHistoryEntryCopyWith<$Res> {
  factory _$GameHistoryEntryCopyWith(_GameHistoryEntry value, $Res Function(_GameHistoryEntry) _then) = __$GameHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime playedAt, int totalScore, List<RoundResult> rounds, int totalDurationMs
});




}
/// @nodoc
class __$GameHistoryEntryCopyWithImpl<$Res>
    implements _$GameHistoryEntryCopyWith<$Res> {
  __$GameHistoryEntryCopyWithImpl(this._self, this._then);

  final _GameHistoryEntry _self;
  final $Res Function(_GameHistoryEntry) _then;

/// Create a copy of GameHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? playedAt = null,Object? totalScore = null,Object? rounds = null,Object? totalDurationMs = null,}) {
  return _then(_GameHistoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,playedAt: null == playedAt ? _self.playedAt : playedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,rounds: null == rounds ? _self._rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<RoundResult>,totalDurationMs: null == totalDurationMs ? _self.totalDurationMs : totalDurationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoundResult {

 bool get isWordGame; int get score; int get timeBonus; String? get userAnswer; String? get bestAnswer;
/// Create a copy of RoundResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoundResultCopyWith<RoundResult> get copyWith => _$RoundResultCopyWithImpl<RoundResult>(this as RoundResult, _$identity);

  /// Serializes this RoundResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoundResult&&(identical(other.isWordGame, isWordGame) || other.isWordGame == isWordGame)&&(identical(other.score, score) || other.score == score)&&(identical(other.timeBonus, timeBonus) || other.timeBonus == timeBonus)&&(identical(other.userAnswer, userAnswer) || other.userAnswer == userAnswer)&&(identical(other.bestAnswer, bestAnswer) || other.bestAnswer == bestAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isWordGame,score,timeBonus,userAnswer,bestAnswer);

@override
String toString() {
  return 'RoundResult(isWordGame: $isWordGame, score: $score, timeBonus: $timeBonus, userAnswer: $userAnswer, bestAnswer: $bestAnswer)';
}


}

/// @nodoc
abstract mixin class $RoundResultCopyWith<$Res>  {
  factory $RoundResultCopyWith(RoundResult value, $Res Function(RoundResult) _then) = _$RoundResultCopyWithImpl;
@useResult
$Res call({
 bool isWordGame, int score, int timeBonus, String? userAnswer, String? bestAnswer
});




}
/// @nodoc
class _$RoundResultCopyWithImpl<$Res>
    implements $RoundResultCopyWith<$Res> {
  _$RoundResultCopyWithImpl(this._self, this._then);

  final RoundResult _self;
  final $Res Function(RoundResult) _then;

/// Create a copy of RoundResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isWordGame = null,Object? score = null,Object? timeBonus = null,Object? userAnswer = freezed,Object? bestAnswer = freezed,}) {
  return _then(_self.copyWith(
isWordGame: null == isWordGame ? _self.isWordGame : isWordGame // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,timeBonus: null == timeBonus ? _self.timeBonus : timeBonus // ignore: cast_nullable_to_non_nullable
as int,userAnswer: freezed == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String?,bestAnswer: freezed == bestAnswer ? _self.bestAnswer : bestAnswer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoundResult].
extension RoundResultPatterns on RoundResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoundResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoundResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoundResult value)  $default,){
final _that = this;
switch (_that) {
case _RoundResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoundResult value)?  $default,){
final _that = this;
switch (_that) {
case _RoundResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isWordGame,  int score,  int timeBonus,  String? userAnswer,  String? bestAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoundResult() when $default != null:
return $default(_that.isWordGame,_that.score,_that.timeBonus,_that.userAnswer,_that.bestAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isWordGame,  int score,  int timeBonus,  String? userAnswer,  String? bestAnswer)  $default,) {final _that = this;
switch (_that) {
case _RoundResult():
return $default(_that.isWordGame,_that.score,_that.timeBonus,_that.userAnswer,_that.bestAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isWordGame,  int score,  int timeBonus,  String? userAnswer,  String? bestAnswer)?  $default,) {final _that = this;
switch (_that) {
case _RoundResult() when $default != null:
return $default(_that.isWordGame,_that.score,_that.timeBonus,_that.userAnswer,_that.bestAnswer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoundResult implements RoundResult {
  const _RoundResult({required this.isWordGame, required this.score, required this.timeBonus, this.userAnswer, this.bestAnswer});
  factory _RoundResult.fromJson(Map<String, dynamic> json) => _$RoundResultFromJson(json);

@override final  bool isWordGame;
@override final  int score;
@override final  int timeBonus;
@override final  String? userAnswer;
@override final  String? bestAnswer;

/// Create a copy of RoundResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoundResultCopyWith<_RoundResult> get copyWith => __$RoundResultCopyWithImpl<_RoundResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoundResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoundResult&&(identical(other.isWordGame, isWordGame) || other.isWordGame == isWordGame)&&(identical(other.score, score) || other.score == score)&&(identical(other.timeBonus, timeBonus) || other.timeBonus == timeBonus)&&(identical(other.userAnswer, userAnswer) || other.userAnswer == userAnswer)&&(identical(other.bestAnswer, bestAnswer) || other.bestAnswer == bestAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isWordGame,score,timeBonus,userAnswer,bestAnswer);

@override
String toString() {
  return 'RoundResult(isWordGame: $isWordGame, score: $score, timeBonus: $timeBonus, userAnswer: $userAnswer, bestAnswer: $bestAnswer)';
}


}

/// @nodoc
abstract mixin class _$RoundResultCopyWith<$Res> implements $RoundResultCopyWith<$Res> {
  factory _$RoundResultCopyWith(_RoundResult value, $Res Function(_RoundResult) _then) = __$RoundResultCopyWithImpl;
@override @useResult
$Res call({
 bool isWordGame, int score, int timeBonus, String? userAnswer, String? bestAnswer
});




}
/// @nodoc
class __$RoundResultCopyWithImpl<$Res>
    implements _$RoundResultCopyWith<$Res> {
  __$RoundResultCopyWithImpl(this._self, this._then);

  final _RoundResult _self;
  final $Res Function(_RoundResult) _then;

/// Create a copy of RoundResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isWordGame = null,Object? score = null,Object? timeBonus = null,Object? userAnswer = freezed,Object? bestAnswer = freezed,}) {
  return _then(_RoundResult(
isWordGame: null == isWordGame ? _self.isWordGame : isWordGame // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,timeBonus: null == timeBonus ? _self.timeBonus : timeBonus // ignore: cast_nullable_to_non_nullable
as int,userAnswer: freezed == userAnswer ? _self.userAnswer : userAnswer // ignore: cast_nullable_to_non_nullable
as String?,bestAnswer: freezed == bestAnswer ? _self.bestAnswer : bestAnswer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
