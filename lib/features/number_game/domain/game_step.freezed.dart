// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameStep {

/// İşlemde kullanılan ilk sayı.
 int get firstNumber;/// İşlemde kullanılan ikinci sayı.
 int get secondNumber;/// Uygulanan işlem türü.
 Operation get operation;/// İşlemin sonucu.
 int get result;/// İşlem öncesi availableNumbers listesinin kopyası (undo için).
 List<int> get previousAvailableNumbers;
/// Create a copy of GameStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStepCopyWith<GameStep> get copyWith => _$GameStepCopyWithImpl<GameStep>(this as GameStep, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStep&&(identical(other.firstNumber, firstNumber) || other.firstNumber == firstNumber)&&(identical(other.secondNumber, secondNumber) || other.secondNumber == secondNumber)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other.previousAvailableNumbers, previousAvailableNumbers));
}


@override
int get hashCode => Object.hash(runtimeType,firstNumber,secondNumber,operation,result,const DeepCollectionEquality().hash(previousAvailableNumbers));

@override
String toString() {
  return 'GameStep(firstNumber: $firstNumber, secondNumber: $secondNumber, operation: $operation, result: $result, previousAvailableNumbers: $previousAvailableNumbers)';
}


}

/// @nodoc
abstract mixin class $GameStepCopyWith<$Res>  {
  factory $GameStepCopyWith(GameStep value, $Res Function(GameStep) _then) = _$GameStepCopyWithImpl;
@useResult
$Res call({
 int firstNumber, int secondNumber, Operation operation, int result, List<int> previousAvailableNumbers
});




}
/// @nodoc
class _$GameStepCopyWithImpl<$Res>
    implements $GameStepCopyWith<$Res> {
  _$GameStepCopyWithImpl(this._self, this._then);

  final GameStep _self;
  final $Res Function(GameStep) _then;

/// Create a copy of GameStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstNumber = null,Object? secondNumber = null,Object? operation = null,Object? result = null,Object? previousAvailableNumbers = null,}) {
  return _then(_self.copyWith(
firstNumber: null == firstNumber ? _self.firstNumber : firstNumber // ignore: cast_nullable_to_non_nullable
as int,secondNumber: null == secondNumber ? _self.secondNumber : secondNumber // ignore: cast_nullable_to_non_nullable
as int,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as Operation,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int,previousAvailableNumbers: null == previousAvailableNumbers ? _self.previousAvailableNumbers : previousAvailableNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameStep].
extension GameStepPatterns on GameStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameStep value)  $default,){
final _that = this;
switch (_that) {
case _GameStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameStep value)?  $default,){
final _that = this;
switch (_that) {
case _GameStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int firstNumber,  int secondNumber,  Operation operation,  int result,  List<int> previousAvailableNumbers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameStep() when $default != null:
return $default(_that.firstNumber,_that.secondNumber,_that.operation,_that.result,_that.previousAvailableNumbers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int firstNumber,  int secondNumber,  Operation operation,  int result,  List<int> previousAvailableNumbers)  $default,) {final _that = this;
switch (_that) {
case _GameStep():
return $default(_that.firstNumber,_that.secondNumber,_that.operation,_that.result,_that.previousAvailableNumbers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int firstNumber,  int secondNumber,  Operation operation,  int result,  List<int> previousAvailableNumbers)?  $default,) {final _that = this;
switch (_that) {
case _GameStep() when $default != null:
return $default(_that.firstNumber,_that.secondNumber,_that.operation,_that.result,_that.previousAvailableNumbers);case _:
  return null;

}
}

}

/// @nodoc


class _GameStep implements GameStep {
  const _GameStep({required this.firstNumber, required this.secondNumber, required this.operation, required this.result, required final  List<int> previousAvailableNumbers}): _previousAvailableNumbers = previousAvailableNumbers;
  

/// İşlemde kullanılan ilk sayı.
@override final  int firstNumber;
/// İşlemde kullanılan ikinci sayı.
@override final  int secondNumber;
/// Uygulanan işlem türü.
@override final  Operation operation;
/// İşlemin sonucu.
@override final  int result;
/// İşlem öncesi availableNumbers listesinin kopyası (undo için).
 final  List<int> _previousAvailableNumbers;
/// İşlem öncesi availableNumbers listesinin kopyası (undo için).
@override List<int> get previousAvailableNumbers {
  if (_previousAvailableNumbers is EqualUnmodifiableListView) return _previousAvailableNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousAvailableNumbers);
}


/// Create a copy of GameStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStepCopyWith<_GameStep> get copyWith => __$GameStepCopyWithImpl<_GameStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameStep&&(identical(other.firstNumber, firstNumber) || other.firstNumber == firstNumber)&&(identical(other.secondNumber, secondNumber) || other.secondNumber == secondNumber)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.result, result) || other.result == result)&&const DeepCollectionEquality().equals(other._previousAvailableNumbers, _previousAvailableNumbers));
}


@override
int get hashCode => Object.hash(runtimeType,firstNumber,secondNumber,operation,result,const DeepCollectionEquality().hash(_previousAvailableNumbers));

@override
String toString() {
  return 'GameStep(firstNumber: $firstNumber, secondNumber: $secondNumber, operation: $operation, result: $result, previousAvailableNumbers: $previousAvailableNumbers)';
}


}

/// @nodoc
abstract mixin class _$GameStepCopyWith<$Res> implements $GameStepCopyWith<$Res> {
  factory _$GameStepCopyWith(_GameStep value, $Res Function(_GameStep) _then) = __$GameStepCopyWithImpl;
@override @useResult
$Res call({
 int firstNumber, int secondNumber, Operation operation, int result, List<int> previousAvailableNumbers
});




}
/// @nodoc
class __$GameStepCopyWithImpl<$Res>
    implements _$GameStepCopyWith<$Res> {
  __$GameStepCopyWithImpl(this._self, this._then);

  final _GameStep _self;
  final $Res Function(_GameStep) _then;

/// Create a copy of GameStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstNumber = null,Object? secondNumber = null,Object? operation = null,Object? result = null,Object? previousAvailableNumbers = null,}) {
  return _then(_GameStep(
firstNumber: null == firstNumber ? _self.firstNumber : firstNumber // ignore: cast_nullable_to_non_nullable
as int,secondNumber: null == secondNumber ? _self.secondNumber : secondNumber // ignore: cast_nullable_to_non_nullable
as int,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as Operation,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int,previousAvailableNumbers: null == previousAvailableNumbers ? _self._previousAvailableNumbers : previousAvailableNumbers // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
