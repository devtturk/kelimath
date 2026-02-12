// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutorial_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TutorialState {

/// Tutorial'ın hangi aşamasında olduğu.
 TutorialPhase get phase;/// Mevcut adım index'i.
 int get currentStepIndex;/// Mevcut aşamadaki adımlar.
 List<TutorialStep> get steps;/// Tutorial atlandı mı?
 bool get isSkipped;/// Tutorial tamamlandı mı?
 bool get isCompleted;/// Kullanıcının yazdığı mevcut kelime (word phase için).
 String get currentWord;/// Mevcut sayılar (number phase için).
 List<int?> get availableNumbers;/// Seçili sayı index'i.
 int? get selectedNumberIndex;/// Seçili işlem.
 String? get selectedOperation;/// İşlem geçmişi.
 List<String> get operationHistory;
/// Create a copy of TutorialState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorialStateCopyWith<TutorialState> get copyWith => _$TutorialStateCopyWithImpl<TutorialState>(this as TutorialState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorialState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.currentWord, currentWord) || other.currentWord == currentWord)&&const DeepCollectionEquality().equals(other.availableNumbers, availableNumbers)&&(identical(other.selectedNumberIndex, selectedNumberIndex) || other.selectedNumberIndex == selectedNumberIndex)&&(identical(other.selectedOperation, selectedOperation) || other.selectedOperation == selectedOperation)&&const DeepCollectionEquality().equals(other.operationHistory, operationHistory));
}


@override
int get hashCode => Object.hash(runtimeType,phase,currentStepIndex,const DeepCollectionEquality().hash(steps),isSkipped,isCompleted,currentWord,const DeepCollectionEquality().hash(availableNumbers),selectedNumberIndex,selectedOperation,const DeepCollectionEquality().hash(operationHistory));

@override
String toString() {
  return 'TutorialState(phase: $phase, currentStepIndex: $currentStepIndex, steps: $steps, isSkipped: $isSkipped, isCompleted: $isCompleted, currentWord: $currentWord, availableNumbers: $availableNumbers, selectedNumberIndex: $selectedNumberIndex, selectedOperation: $selectedOperation, operationHistory: $operationHistory)';
}


}

/// @nodoc
abstract mixin class $TutorialStateCopyWith<$Res>  {
  factory $TutorialStateCopyWith(TutorialState value, $Res Function(TutorialState) _then) = _$TutorialStateCopyWithImpl;
@useResult
$Res call({
 TutorialPhase phase, int currentStepIndex, List<TutorialStep> steps, bool isSkipped, bool isCompleted, String currentWord, List<int?> availableNumbers, int? selectedNumberIndex, String? selectedOperation, List<String> operationHistory
});




}
/// @nodoc
class _$TutorialStateCopyWithImpl<$Res>
    implements $TutorialStateCopyWith<$Res> {
  _$TutorialStateCopyWithImpl(this._self, this._then);

  final TutorialState _self;
  final $Res Function(TutorialState) _then;

/// Create a copy of TutorialState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? currentStepIndex = null,Object? steps = null,Object? isSkipped = null,Object? isCompleted = null,Object? currentWord = null,Object? availableNumbers = null,Object? selectedNumberIndex = freezed,Object? selectedOperation = freezed,Object? operationHistory = null,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as TutorialPhase,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<TutorialStep>,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,currentWord: null == currentWord ? _self.currentWord : currentWord // ignore: cast_nullable_to_non_nullable
as String,availableNumbers: null == availableNumbers ? _self.availableNumbers : availableNumbers // ignore: cast_nullable_to_non_nullable
as List<int?>,selectedNumberIndex: freezed == selectedNumberIndex ? _self.selectedNumberIndex : selectedNumberIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedOperation: freezed == selectedOperation ? _self.selectedOperation : selectedOperation // ignore: cast_nullable_to_non_nullable
as String?,operationHistory: null == operationHistory ? _self.operationHistory : operationHistory // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TutorialState].
extension TutorialStatePatterns on TutorialState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TutorialState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TutorialState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TutorialState value)  $default,){
final _that = this;
switch (_that) {
case _TutorialState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TutorialState value)?  $default,){
final _that = this;
switch (_that) {
case _TutorialState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TutorialPhase phase,  int currentStepIndex,  List<TutorialStep> steps,  bool isSkipped,  bool isCompleted,  String currentWord,  List<int?> availableNumbers,  int? selectedNumberIndex,  String? selectedOperation,  List<String> operationHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TutorialState() when $default != null:
return $default(_that.phase,_that.currentStepIndex,_that.steps,_that.isSkipped,_that.isCompleted,_that.currentWord,_that.availableNumbers,_that.selectedNumberIndex,_that.selectedOperation,_that.operationHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TutorialPhase phase,  int currentStepIndex,  List<TutorialStep> steps,  bool isSkipped,  bool isCompleted,  String currentWord,  List<int?> availableNumbers,  int? selectedNumberIndex,  String? selectedOperation,  List<String> operationHistory)  $default,) {final _that = this;
switch (_that) {
case _TutorialState():
return $default(_that.phase,_that.currentStepIndex,_that.steps,_that.isSkipped,_that.isCompleted,_that.currentWord,_that.availableNumbers,_that.selectedNumberIndex,_that.selectedOperation,_that.operationHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TutorialPhase phase,  int currentStepIndex,  List<TutorialStep> steps,  bool isSkipped,  bool isCompleted,  String currentWord,  List<int?> availableNumbers,  int? selectedNumberIndex,  String? selectedOperation,  List<String> operationHistory)?  $default,) {final _that = this;
switch (_that) {
case _TutorialState() when $default != null:
return $default(_that.phase,_that.currentStepIndex,_that.steps,_that.isSkipped,_that.isCompleted,_that.currentWord,_that.availableNumbers,_that.selectedNumberIndex,_that.selectedOperation,_that.operationHistory);case _:
  return null;

}
}

}

/// @nodoc


class _TutorialState extends TutorialState {
  const _TutorialState({required this.phase, required this.currentStepIndex, required final  List<TutorialStep> steps, this.isSkipped = false, this.isCompleted = false, this.currentWord = '', final  List<int?> availableNumbers = const [], this.selectedNumberIndex, this.selectedOperation, final  List<String> operationHistory = const []}): _steps = steps,_availableNumbers = availableNumbers,_operationHistory = operationHistory,super._();
  

/// Tutorial'ın hangi aşamasında olduğu.
@override final  TutorialPhase phase;
/// Mevcut adım index'i.
@override final  int currentStepIndex;
/// Mevcut aşamadaki adımlar.
 final  List<TutorialStep> _steps;
/// Mevcut aşamadaki adımlar.
@override List<TutorialStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

/// Tutorial atlandı mı?
@override@JsonKey() final  bool isSkipped;
/// Tutorial tamamlandı mı?
@override@JsonKey() final  bool isCompleted;
/// Kullanıcının yazdığı mevcut kelime (word phase için).
@override@JsonKey() final  String currentWord;
/// Mevcut sayılar (number phase için).
 final  List<int?> _availableNumbers;
/// Mevcut sayılar (number phase için).
@override@JsonKey() List<int?> get availableNumbers {
  if (_availableNumbers is EqualUnmodifiableListView) return _availableNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableNumbers);
}

/// Seçili sayı index'i.
@override final  int? selectedNumberIndex;
/// Seçili işlem.
@override final  String? selectedOperation;
/// İşlem geçmişi.
 final  List<String> _operationHistory;
/// İşlem geçmişi.
@override@JsonKey() List<String> get operationHistory {
  if (_operationHistory is EqualUnmodifiableListView) return _operationHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_operationHistory);
}


/// Create a copy of TutorialState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorialStateCopyWith<_TutorialState> get copyWith => __$TutorialStateCopyWithImpl<_TutorialState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TutorialState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.isSkipped, isSkipped) || other.isSkipped == isSkipped)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.currentWord, currentWord) || other.currentWord == currentWord)&&const DeepCollectionEquality().equals(other._availableNumbers, _availableNumbers)&&(identical(other.selectedNumberIndex, selectedNumberIndex) || other.selectedNumberIndex == selectedNumberIndex)&&(identical(other.selectedOperation, selectedOperation) || other.selectedOperation == selectedOperation)&&const DeepCollectionEquality().equals(other._operationHistory, _operationHistory));
}


@override
int get hashCode => Object.hash(runtimeType,phase,currentStepIndex,const DeepCollectionEquality().hash(_steps),isSkipped,isCompleted,currentWord,const DeepCollectionEquality().hash(_availableNumbers),selectedNumberIndex,selectedOperation,const DeepCollectionEquality().hash(_operationHistory));

@override
String toString() {
  return 'TutorialState(phase: $phase, currentStepIndex: $currentStepIndex, steps: $steps, isSkipped: $isSkipped, isCompleted: $isCompleted, currentWord: $currentWord, availableNumbers: $availableNumbers, selectedNumberIndex: $selectedNumberIndex, selectedOperation: $selectedOperation, operationHistory: $operationHistory)';
}


}

/// @nodoc
abstract mixin class _$TutorialStateCopyWith<$Res> implements $TutorialStateCopyWith<$Res> {
  factory _$TutorialStateCopyWith(_TutorialState value, $Res Function(_TutorialState) _then) = __$TutorialStateCopyWithImpl;
@override @useResult
$Res call({
 TutorialPhase phase, int currentStepIndex, List<TutorialStep> steps, bool isSkipped, bool isCompleted, String currentWord, List<int?> availableNumbers, int? selectedNumberIndex, String? selectedOperation, List<String> operationHistory
});




}
/// @nodoc
class __$TutorialStateCopyWithImpl<$Res>
    implements _$TutorialStateCopyWith<$Res> {
  __$TutorialStateCopyWithImpl(this._self, this._then);

  final _TutorialState _self;
  final $Res Function(_TutorialState) _then;

/// Create a copy of TutorialState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? currentStepIndex = null,Object? steps = null,Object? isSkipped = null,Object? isCompleted = null,Object? currentWord = null,Object? availableNumbers = null,Object? selectedNumberIndex = freezed,Object? selectedOperation = freezed,Object? operationHistory = null,}) {
  return _then(_TutorialState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as TutorialPhase,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<TutorialStep>,isSkipped: null == isSkipped ? _self.isSkipped : isSkipped // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,currentWord: null == currentWord ? _self.currentWord : currentWord // ignore: cast_nullable_to_non_nullable
as String,availableNumbers: null == availableNumbers ? _self._availableNumbers : availableNumbers // ignore: cast_nullable_to_non_nullable
as List<int?>,selectedNumberIndex: freezed == selectedNumberIndex ? _self.selectedNumberIndex : selectedNumberIndex // ignore: cast_nullable_to_non_nullable
as int?,selectedOperation: freezed == selectedOperation ? _self.selectedOperation : selectedOperation // ignore: cast_nullable_to_non_nullable
as String?,operationHistory: null == operationHistory ? _self._operationHistory : operationHistory // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
