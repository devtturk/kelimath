// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solver_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SolverResult {

/// Bulunan en yakın sayı.
 int get result;/// Hedefe olan mesafe: |target - result|.
 int get distance;/// Çözüme ulaşmak için gereken adımlar.
 List<SolverStep> get steps;/// Tam eşleşme bulundu mu (distance == 0)?
 bool get isExact;
/// Create a copy of SolverResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolverResultCopyWith<SolverResult> get copyWith => _$SolverResultCopyWithImpl<SolverResult>(this as SolverResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolverResult&&(identical(other.result, result) || other.result == result)&&(identical(other.distance, distance) || other.distance == distance)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.isExact, isExact) || other.isExact == isExact));
}


@override
int get hashCode => Object.hash(runtimeType,result,distance,const DeepCollectionEquality().hash(steps),isExact);

@override
String toString() {
  return 'SolverResult(result: $result, distance: $distance, steps: $steps, isExact: $isExact)';
}


}

/// @nodoc
abstract mixin class $SolverResultCopyWith<$Res>  {
  factory $SolverResultCopyWith(SolverResult value, $Res Function(SolverResult) _then) = _$SolverResultCopyWithImpl;
@useResult
$Res call({
 int result, int distance, List<SolverStep> steps, bool isExact
});




}
/// @nodoc
class _$SolverResultCopyWithImpl<$Res>
    implements $SolverResultCopyWith<$Res> {
  _$SolverResultCopyWithImpl(this._self, this._then);

  final SolverResult _self;
  final $Res Function(SolverResult) _then;

/// Create a copy of SolverResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? distance = null,Object? steps = null,Object? isExact = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<SolverStep>,isExact: null == isExact ? _self.isExact : isExact // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SolverResult].
extension SolverResultPatterns on SolverResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SolverResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SolverResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SolverResult value)  $default,){
final _that = this;
switch (_that) {
case _SolverResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SolverResult value)?  $default,){
final _that = this;
switch (_that) {
case _SolverResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int result,  int distance,  List<SolverStep> steps,  bool isExact)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SolverResult() when $default != null:
return $default(_that.result,_that.distance,_that.steps,_that.isExact);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int result,  int distance,  List<SolverStep> steps,  bool isExact)  $default,) {final _that = this;
switch (_that) {
case _SolverResult():
return $default(_that.result,_that.distance,_that.steps,_that.isExact);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int result,  int distance,  List<SolverStep> steps,  bool isExact)?  $default,) {final _that = this;
switch (_that) {
case _SolverResult() when $default != null:
return $default(_that.result,_that.distance,_that.steps,_that.isExact);case _:
  return null;

}
}

}

/// @nodoc


class _SolverResult extends SolverResult {
  const _SolverResult({required this.result, required this.distance, required final  List<SolverStep> steps, required this.isExact}): _steps = steps,super._();
  

/// Bulunan en yakın sayı.
@override final  int result;
/// Hedefe olan mesafe: |target - result|.
@override final  int distance;
/// Çözüme ulaşmak için gereken adımlar.
 final  List<SolverStep> _steps;
/// Çözüme ulaşmak için gereken adımlar.
@override List<SolverStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

/// Tam eşleşme bulundu mu (distance == 0)?
@override final  bool isExact;

/// Create a copy of SolverResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SolverResultCopyWith<_SolverResult> get copyWith => __$SolverResultCopyWithImpl<_SolverResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SolverResult&&(identical(other.result, result) || other.result == result)&&(identical(other.distance, distance) || other.distance == distance)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.isExact, isExact) || other.isExact == isExact));
}


@override
int get hashCode => Object.hash(runtimeType,result,distance,const DeepCollectionEquality().hash(_steps),isExact);

@override
String toString() {
  return 'SolverResult(result: $result, distance: $distance, steps: $steps, isExact: $isExact)';
}


}

/// @nodoc
abstract mixin class _$SolverResultCopyWith<$Res> implements $SolverResultCopyWith<$Res> {
  factory _$SolverResultCopyWith(_SolverResult value, $Res Function(_SolverResult) _then) = __$SolverResultCopyWithImpl;
@override @useResult
$Res call({
 int result, int distance, List<SolverStep> steps, bool isExact
});




}
/// @nodoc
class __$SolverResultCopyWithImpl<$Res>
    implements _$SolverResultCopyWith<$Res> {
  __$SolverResultCopyWithImpl(this._self, this._then);

  final _SolverResult _self;
  final $Res Function(_SolverResult) _then;

/// Create a copy of SolverResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? distance = null,Object? steps = null,Object? isExact = null,}) {
  return _then(_SolverResult(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<SolverStep>,isExact: null == isExact ? _self.isExact : isExact // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SolverStep {

 int get firstNumber; int get secondNumber; String get operation; int get result;
/// Create a copy of SolverStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolverStepCopyWith<SolverStep> get copyWith => _$SolverStepCopyWithImpl<SolverStep>(this as SolverStep, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolverStep&&(identical(other.firstNumber, firstNumber) || other.firstNumber == firstNumber)&&(identical(other.secondNumber, secondNumber) || other.secondNumber == secondNumber)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,firstNumber,secondNumber,operation,result);

@override
String toString() {
  return 'SolverStep(firstNumber: $firstNumber, secondNumber: $secondNumber, operation: $operation, result: $result)';
}


}

/// @nodoc
abstract mixin class $SolverStepCopyWith<$Res>  {
  factory $SolverStepCopyWith(SolverStep value, $Res Function(SolverStep) _then) = _$SolverStepCopyWithImpl;
@useResult
$Res call({
 int firstNumber, int secondNumber, String operation, int result
});




}
/// @nodoc
class _$SolverStepCopyWithImpl<$Res>
    implements $SolverStepCopyWith<$Res> {
  _$SolverStepCopyWithImpl(this._self, this._then);

  final SolverStep _self;
  final $Res Function(SolverStep) _then;

/// Create a copy of SolverStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstNumber = null,Object? secondNumber = null,Object? operation = null,Object? result = null,}) {
  return _then(_self.copyWith(
firstNumber: null == firstNumber ? _self.firstNumber : firstNumber // ignore: cast_nullable_to_non_nullable
as int,secondNumber: null == secondNumber ? _self.secondNumber : secondNumber // ignore: cast_nullable_to_non_nullable
as int,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SolverStep].
extension SolverStepPatterns on SolverStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SolverStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SolverStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SolverStep value)  $default,){
final _that = this;
switch (_that) {
case _SolverStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SolverStep value)?  $default,){
final _that = this;
switch (_that) {
case _SolverStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int firstNumber,  int secondNumber,  String operation,  int result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SolverStep() when $default != null:
return $default(_that.firstNumber,_that.secondNumber,_that.operation,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int firstNumber,  int secondNumber,  String operation,  int result)  $default,) {final _that = this;
switch (_that) {
case _SolverStep():
return $default(_that.firstNumber,_that.secondNumber,_that.operation,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int firstNumber,  int secondNumber,  String operation,  int result)?  $default,) {final _that = this;
switch (_that) {
case _SolverStep() when $default != null:
return $default(_that.firstNumber,_that.secondNumber,_that.operation,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _SolverStep extends SolverStep {
  const _SolverStep({required this.firstNumber, required this.secondNumber, required this.operation, required this.result}): super._();
  

@override final  int firstNumber;
@override final  int secondNumber;
@override final  String operation;
@override final  int result;

/// Create a copy of SolverStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SolverStepCopyWith<_SolverStep> get copyWith => __$SolverStepCopyWithImpl<_SolverStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SolverStep&&(identical(other.firstNumber, firstNumber) || other.firstNumber == firstNumber)&&(identical(other.secondNumber, secondNumber) || other.secondNumber == secondNumber)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,firstNumber,secondNumber,operation,result);

@override
String toString() {
  return 'SolverStep(firstNumber: $firstNumber, secondNumber: $secondNumber, operation: $operation, result: $result)';
}


}

/// @nodoc
abstract mixin class _$SolverStepCopyWith<$Res> implements $SolverStepCopyWith<$Res> {
  factory _$SolverStepCopyWith(_SolverStep value, $Res Function(_SolverStep) _then) = __$SolverStepCopyWithImpl;
@override @useResult
$Res call({
 int firstNumber, int secondNumber, String operation, int result
});




}
/// @nodoc
class __$SolverStepCopyWithImpl<$Res>
    implements _$SolverStepCopyWith<$Res> {
  __$SolverStepCopyWithImpl(this._self, this._then);

  final _SolverStep _self;
  final $Res Function(_SolverStep) _then;

/// Create a copy of SolverStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstNumber = null,Object? secondNumber = null,Object? operation = null,Object? result = null,}) {
  return _then(_SolverStep(
firstNumber: null == firstNumber ? _self.firstNumber : firstNumber // ignore: cast_nullable_to_non_nullable
as int,secondNumber: null == secondNumber ? _self.secondNumber : secondNumber // ignore: cast_nullable_to_non_nullable
as int,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
