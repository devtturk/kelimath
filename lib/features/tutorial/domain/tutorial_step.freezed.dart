// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutorial_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TutorialStep {

/// Adım numarası (görsel gösterim için).
 int get stepNumber;/// Kullanıcıya gösterilecek talimat.
 String get instruction;/// Bu adımda beklenen aksiyon.
 TutorialAction get action;/// Hedef tuş (tapLetter için, örn: "K").
 String? get targetKey;/// Hedef index (tapNumber, tapLetterRack için).
 int? get targetIndex;/// Hedef işlem (+, -, ×, ÷) string olarak.
 String? get targetOperation;/// Tooltip'in ekranda nereye konumlanacağı (top/bottom).
 TooltipPosition get tooltipPosition;
/// Create a copy of TutorialStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorialStepCopyWith<TutorialStep> get copyWith => _$TutorialStepCopyWithImpl<TutorialStep>(this as TutorialStep, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorialStep&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.action, action) || other.action == action)&&(identical(other.targetKey, targetKey) || other.targetKey == targetKey)&&(identical(other.targetIndex, targetIndex) || other.targetIndex == targetIndex)&&(identical(other.targetOperation, targetOperation) || other.targetOperation == targetOperation)&&(identical(other.tooltipPosition, tooltipPosition) || other.tooltipPosition == tooltipPosition));
}


@override
int get hashCode => Object.hash(runtimeType,stepNumber,instruction,action,targetKey,targetIndex,targetOperation,tooltipPosition);

@override
String toString() {
  return 'TutorialStep(stepNumber: $stepNumber, instruction: $instruction, action: $action, targetKey: $targetKey, targetIndex: $targetIndex, targetOperation: $targetOperation, tooltipPosition: $tooltipPosition)';
}


}

/// @nodoc
abstract mixin class $TutorialStepCopyWith<$Res>  {
  factory $TutorialStepCopyWith(TutorialStep value, $Res Function(TutorialStep) _then) = _$TutorialStepCopyWithImpl;
@useResult
$Res call({
 int stepNumber, String instruction, TutorialAction action, String? targetKey, int? targetIndex, String? targetOperation, TooltipPosition tooltipPosition
});




}
/// @nodoc
class _$TutorialStepCopyWithImpl<$Res>
    implements $TutorialStepCopyWith<$Res> {
  _$TutorialStepCopyWithImpl(this._self, this._then);

  final TutorialStep _self;
  final $Res Function(TutorialStep) _then;

/// Create a copy of TutorialStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNumber = null,Object? instruction = null,Object? action = null,Object? targetKey = freezed,Object? targetIndex = freezed,Object? targetOperation = freezed,Object? tooltipPosition = null,}) {
  return _then(_self.copyWith(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as TutorialAction,targetKey: freezed == targetKey ? _self.targetKey : targetKey // ignore: cast_nullable_to_non_nullable
as String?,targetIndex: freezed == targetIndex ? _self.targetIndex : targetIndex // ignore: cast_nullable_to_non_nullable
as int?,targetOperation: freezed == targetOperation ? _self.targetOperation : targetOperation // ignore: cast_nullable_to_non_nullable
as String?,tooltipPosition: null == tooltipPosition ? _self.tooltipPosition : tooltipPosition // ignore: cast_nullable_to_non_nullable
as TooltipPosition,
  ));
}

}


/// Adds pattern-matching-related methods to [TutorialStep].
extension TutorialStepPatterns on TutorialStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TutorialStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TutorialStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TutorialStep value)  $default,){
final _that = this;
switch (_that) {
case _TutorialStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TutorialStep value)?  $default,){
final _that = this;
switch (_that) {
case _TutorialStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNumber,  String instruction,  TutorialAction action,  String? targetKey,  int? targetIndex,  String? targetOperation,  TooltipPosition tooltipPosition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TutorialStep() when $default != null:
return $default(_that.stepNumber,_that.instruction,_that.action,_that.targetKey,_that.targetIndex,_that.targetOperation,_that.tooltipPosition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNumber,  String instruction,  TutorialAction action,  String? targetKey,  int? targetIndex,  String? targetOperation,  TooltipPosition tooltipPosition)  $default,) {final _that = this;
switch (_that) {
case _TutorialStep():
return $default(_that.stepNumber,_that.instruction,_that.action,_that.targetKey,_that.targetIndex,_that.targetOperation,_that.tooltipPosition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNumber,  String instruction,  TutorialAction action,  String? targetKey,  int? targetIndex,  String? targetOperation,  TooltipPosition tooltipPosition)?  $default,) {final _that = this;
switch (_that) {
case _TutorialStep() when $default != null:
return $default(_that.stepNumber,_that.instruction,_that.action,_that.targetKey,_that.targetIndex,_that.targetOperation,_that.tooltipPosition);case _:
  return null;

}
}

}

/// @nodoc


class _TutorialStep implements TutorialStep {
  const _TutorialStep({required this.stepNumber, required this.instruction, required this.action, this.targetKey, this.targetIndex, this.targetOperation, this.tooltipPosition = TooltipPosition.bottom});
  

/// Adım numarası (görsel gösterim için).
@override final  int stepNumber;
/// Kullanıcıya gösterilecek talimat.
@override final  String instruction;
/// Bu adımda beklenen aksiyon.
@override final  TutorialAction action;
/// Hedef tuş (tapLetter için, örn: "K").
@override final  String? targetKey;
/// Hedef index (tapNumber, tapLetterRack için).
@override final  int? targetIndex;
/// Hedef işlem (+, -, ×, ÷) string olarak.
@override final  String? targetOperation;
/// Tooltip'in ekranda nereye konumlanacağı (top/bottom).
@override@JsonKey() final  TooltipPosition tooltipPosition;

/// Create a copy of TutorialStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorialStepCopyWith<_TutorialStep> get copyWith => __$TutorialStepCopyWithImpl<_TutorialStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TutorialStep&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.action, action) || other.action == action)&&(identical(other.targetKey, targetKey) || other.targetKey == targetKey)&&(identical(other.targetIndex, targetIndex) || other.targetIndex == targetIndex)&&(identical(other.targetOperation, targetOperation) || other.targetOperation == targetOperation)&&(identical(other.tooltipPosition, tooltipPosition) || other.tooltipPosition == tooltipPosition));
}


@override
int get hashCode => Object.hash(runtimeType,stepNumber,instruction,action,targetKey,targetIndex,targetOperation,tooltipPosition);

@override
String toString() {
  return 'TutorialStep(stepNumber: $stepNumber, instruction: $instruction, action: $action, targetKey: $targetKey, targetIndex: $targetIndex, targetOperation: $targetOperation, tooltipPosition: $tooltipPosition)';
}


}

/// @nodoc
abstract mixin class _$TutorialStepCopyWith<$Res> implements $TutorialStepCopyWith<$Res> {
  factory _$TutorialStepCopyWith(_TutorialStep value, $Res Function(_TutorialStep) _then) = __$TutorialStepCopyWithImpl;
@override @useResult
$Res call({
 int stepNumber, String instruction, TutorialAction action, String? targetKey, int? targetIndex, String? targetOperation, TooltipPosition tooltipPosition
});




}
/// @nodoc
class __$TutorialStepCopyWithImpl<$Res>
    implements _$TutorialStepCopyWith<$Res> {
  __$TutorialStepCopyWithImpl(this._self, this._then);

  final _TutorialStep _self;
  final $Res Function(_TutorialStep) _then;

/// Create a copy of TutorialStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNumber = null,Object? instruction = null,Object? action = null,Object? targetKey = freezed,Object? targetIndex = freezed,Object? targetOperation = freezed,Object? tooltipPosition = null,}) {
  return _then(_TutorialStep(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as TutorialAction,targetKey: freezed == targetKey ? _self.targetKey : targetKey // ignore: cast_nullable_to_non_nullable
as String?,targetIndex: freezed == targetIndex ? _self.targetIndex : targetIndex // ignore: cast_nullable_to_non_nullable
as int?,targetOperation: freezed == targetOperation ? _self.targetOperation : targetOperation // ignore: cast_nullable_to_non_nullable
as String?,tooltipPosition: null == tooltipPosition ? _self.tooltipPosition : tooltipPosition // ignore: cast_nullable_to_non_nullable
as TooltipPosition,
  ));
}


}

// dart format on
