// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'number_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NumberGameState {

/// Ulaşılması gereken hedef sayı (100-999 arası, asal olmayan).
 int get targetNumber;/// Şu an kullanılabilir sayılar listesi.
/// İşlem yapıldıkça kullanılan sayılar silinir, sonuç eklenir.
 List<int> get availableNumbers;/// Oyunun başlangıcındaki sayılar (reset için).
 List<int> get initialNumbers;/// Yapılan işlemlerin geçmişi (undo ve adım sayısı için).
 List<GameStep> get history;/// Seçili olan ilk sayının index'i (UI highlight için).
 int? get selectedNumberIndex;/// Seçili operatör.
 Operation? get selectedOperation;/// Kalan süre (saniye). Varsayılan 90 saniye.
 int get timeRemaining;/// Oyun durumu.
 GameStatus get status;/// Kazanılan puan (submit sonrası hesaplanır).
 int get score;/// Zaman bonusu (submit sonrası hesaplanır).
 int get timeBonus;
/// Create a copy of NumberGameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberGameStateCopyWith<NumberGameState> get copyWith => _$NumberGameStateCopyWithImpl<NumberGameState>(this as NumberGameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberGameState&&(identical(other.targetNumber, targetNumber) || other.targetNumber == targetNumber)&&const DeepCollectionEquality().equals(other.availableNumbers, availableNumbers)&&const DeepCollectionEquality().equals(other.initialNumbers, initialNumbers)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.selectedNumberIndex, selectedNumberIndex) || other.selectedNumberIndex == selectedNumberIndex)&&(identical(other.selectedOperation, selectedOperation) || other.selectedOperation == selectedOperation)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining)&&(identical(other.status, status) || other.status == status)&&(identical(other.score, score) || other.score == score)&&(identical(other.timeBonus, timeBonus) || other.timeBonus == timeBonus));
}


@override
int get hashCode => Object.hash(runtimeType,targetNumber,const DeepCollectionEquality().hash(availableNumbers),const DeepCollectionEquality().hash(initialNumbers),const DeepCollectionEquality().hash(history),selectedNumberIndex,selectedOperation,timeRemaining,status,score,timeBonus);

@override
String toString() {
  return 'NumberGameState(targetNumber: $targetNumber, availableNumbers: $availableNumbers, initialNumbers: $initialNumbers, history: $history, selectedNumberIndex: $selectedNumberIndex, selectedOperation: $selectedOperation, timeRemaining: $timeRemaining, status: $status, score: $score, timeBonus: $timeBonus)';
}


}

/// @nodoc
abstract mixin class $NumberGameStateCopyWith<$Res>  {
  factory $NumberGameStateCopyWith(NumberGameState value, $Res Function(NumberGameState) _then) = _$NumberGameStateCopyWithImpl;
@useResult
$Res call({
 int targetNumber, List<int> availableNumbers, List<int> initialNumbers, List<GameStep> history, int? selectedNumberIndex, Operation? selectedOperation, int timeRemaining, GameStatus status, int score, int timeBonus
});




}
/// @nodoc
class _$NumberGameStateCopyWithImpl<$Res>
    implements $NumberGameStateCopyWith<$Res> {
  _$NumberGameStateCopyWithImpl(this._self, this._then);

  final NumberGameState _self;
  final $Res Function(NumberGameState) _then;

/// Create a copy of NumberGameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetNumber = null,Object? availableNumbers = null,Object? initialNumbers = null,Object? history = null,Object? selectedNumberIndex = freezed,Object? selectedOperation = freezed,Object? timeRemaining = null,Object? status = null,Object? score = null,Object? timeBonus = null,}) {
  return _then(_self.copyWith(
targetNumber: null == targetNumber ? _self.targetNumber : targetNumber // ignore: cast_nullable_to_non_nullable
as int,availableNumbers: null == availableNumbers ? _self.availableNumbers : availableNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,initialNumbers: null == initialNumbers ? _self.initialNumbers : initialNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<GameStep>,selectedNumberIndex: freezed == selectedNumberIndex ? _self.selectedNumberIndex : selectedNumberIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedOperation: freezed == selectedOperation ? _self.selectedOperation : selectedOperation // ignore: cast_nullable_to_non_nullable
as Operation?,timeRemaining: null == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,timeBonus: null == timeBonus ? _self.timeBonus : timeBonus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NumberGameState].
extension NumberGameStatePatterns on NumberGameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NumberGameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NumberGameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NumberGameState value)  $default,){
final _that = this;
switch (_that) {
case _NumberGameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NumberGameState value)?  $default,){
final _that = this;
switch (_that) {
case _NumberGameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int targetNumber,  List<int> availableNumbers,  List<int> initialNumbers,  List<GameStep> history,  int? selectedNumberIndex,  Operation? selectedOperation,  int timeRemaining,  GameStatus status,  int score,  int timeBonus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NumberGameState() when $default != null:
return $default(_that.targetNumber,_that.availableNumbers,_that.initialNumbers,_that.history,_that.selectedNumberIndex,_that.selectedOperation,_that.timeRemaining,_that.status,_that.score,_that.timeBonus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int targetNumber,  List<int> availableNumbers,  List<int> initialNumbers,  List<GameStep> history,  int? selectedNumberIndex,  Operation? selectedOperation,  int timeRemaining,  GameStatus status,  int score,  int timeBonus)  $default,) {final _that = this;
switch (_that) {
case _NumberGameState():
return $default(_that.targetNumber,_that.availableNumbers,_that.initialNumbers,_that.history,_that.selectedNumberIndex,_that.selectedOperation,_that.timeRemaining,_that.status,_that.score,_that.timeBonus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int targetNumber,  List<int> availableNumbers,  List<int> initialNumbers,  List<GameStep> history,  int? selectedNumberIndex,  Operation? selectedOperation,  int timeRemaining,  GameStatus status,  int score,  int timeBonus)?  $default,) {final _that = this;
switch (_that) {
case _NumberGameState() when $default != null:
return $default(_that.targetNumber,_that.availableNumbers,_that.initialNumbers,_that.history,_that.selectedNumberIndex,_that.selectedOperation,_that.timeRemaining,_that.status,_that.score,_that.timeBonus);case _:
  return null;

}
}

}

/// @nodoc


class _NumberGameState extends NumberGameState {
  const _NumberGameState({required this.targetNumber, required final  List<int> availableNumbers, required final  List<int> initialNumbers, final  List<GameStep> history = const [], this.selectedNumberIndex, this.selectedOperation, this.timeRemaining = 90, this.status = GameStatus.notStarted, this.score = 0, this.timeBonus = 0}): _availableNumbers = availableNumbers,_initialNumbers = initialNumbers,_history = history,super._();
  

/// Ulaşılması gereken hedef sayı (100-999 arası, asal olmayan).
@override final  int targetNumber;
/// Şu an kullanılabilir sayılar listesi.
/// İşlem yapıldıkça kullanılan sayılar silinir, sonuç eklenir.
 final  List<int> _availableNumbers;
/// Şu an kullanılabilir sayılar listesi.
/// İşlem yapıldıkça kullanılan sayılar silinir, sonuç eklenir.
@override List<int> get availableNumbers {
  if (_availableNumbers is EqualUnmodifiableListView) return _availableNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableNumbers);
}

/// Oyunun başlangıcındaki sayılar (reset için).
 final  List<int> _initialNumbers;
/// Oyunun başlangıcındaki sayılar (reset için).
@override List<int> get initialNumbers {
  if (_initialNumbers is EqualUnmodifiableListView) return _initialNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialNumbers);
}

/// Yapılan işlemlerin geçmişi (undo ve adım sayısı için).
 final  List<GameStep> _history;
/// Yapılan işlemlerin geçmişi (undo ve adım sayısı için).
@override@JsonKey() List<GameStep> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

/// Seçili olan ilk sayının index'i (UI highlight için).
@override final  int? selectedNumberIndex;
/// Seçili operatör.
@override final  Operation? selectedOperation;
/// Kalan süre (saniye). Varsayılan 90 saniye.
@override@JsonKey() final  int timeRemaining;
/// Oyun durumu.
@override@JsonKey() final  GameStatus status;
/// Kazanılan puan (submit sonrası hesaplanır).
@override@JsonKey() final  int score;
/// Zaman bonusu (submit sonrası hesaplanır).
@override@JsonKey() final  int timeBonus;

/// Create a copy of NumberGameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NumberGameStateCopyWith<_NumberGameState> get copyWith => __$NumberGameStateCopyWithImpl<_NumberGameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NumberGameState&&(identical(other.targetNumber, targetNumber) || other.targetNumber == targetNumber)&&const DeepCollectionEquality().equals(other._availableNumbers, _availableNumbers)&&const DeepCollectionEquality().equals(other._initialNumbers, _initialNumbers)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.selectedNumberIndex, selectedNumberIndex) || other.selectedNumberIndex == selectedNumberIndex)&&(identical(other.selectedOperation, selectedOperation) || other.selectedOperation == selectedOperation)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining)&&(identical(other.status, status) || other.status == status)&&(identical(other.score, score) || other.score == score)&&(identical(other.timeBonus, timeBonus) || other.timeBonus == timeBonus));
}


@override
int get hashCode => Object.hash(runtimeType,targetNumber,const DeepCollectionEquality().hash(_availableNumbers),const DeepCollectionEquality().hash(_initialNumbers),const DeepCollectionEquality().hash(_history),selectedNumberIndex,selectedOperation,timeRemaining,status,score,timeBonus);

@override
String toString() {
  return 'NumberGameState(targetNumber: $targetNumber, availableNumbers: $availableNumbers, initialNumbers: $initialNumbers, history: $history, selectedNumberIndex: $selectedNumberIndex, selectedOperation: $selectedOperation, timeRemaining: $timeRemaining, status: $status, score: $score, timeBonus: $timeBonus)';
}


}

/// @nodoc
abstract mixin class _$NumberGameStateCopyWith<$Res> implements $NumberGameStateCopyWith<$Res> {
  factory _$NumberGameStateCopyWith(_NumberGameState value, $Res Function(_NumberGameState) _then) = __$NumberGameStateCopyWithImpl;
@override @useResult
$Res call({
 int targetNumber, List<int> availableNumbers, List<int> initialNumbers, List<GameStep> history, int? selectedNumberIndex, Operation? selectedOperation, int timeRemaining, GameStatus status, int score, int timeBonus
});




}
/// @nodoc
class __$NumberGameStateCopyWithImpl<$Res>
    implements _$NumberGameStateCopyWith<$Res> {
  __$NumberGameStateCopyWithImpl(this._self, this._then);

  final _NumberGameState _self;
  final $Res Function(_NumberGameState) _then;

/// Create a copy of NumberGameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetNumber = null,Object? availableNumbers = null,Object? initialNumbers = null,Object? history = null,Object? selectedNumberIndex = freezed,Object? selectedOperation = freezed,Object? timeRemaining = null,Object? status = null,Object? score = null,Object? timeBonus = null,}) {
  return _then(_NumberGameState(
targetNumber: null == targetNumber ? _self.targetNumber : targetNumber // ignore: cast_nullable_to_non_nullable
as int,availableNumbers: null == availableNumbers ? _self._availableNumbers : availableNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,initialNumbers: null == initialNumbers ? _self._initialNumbers : initialNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<GameStep>,selectedNumberIndex: freezed == selectedNumberIndex ? _self.selectedNumberIndex : selectedNumberIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedOperation: freezed == selectedOperation ? _self.selectedOperation : selectedOperation // ignore: cast_nullable_to_non_nullable
as Operation?,timeRemaining: null == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,timeBonus: null == timeBonus ? _self.timeBonus : timeBonus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
