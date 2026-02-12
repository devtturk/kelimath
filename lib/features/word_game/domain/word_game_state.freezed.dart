// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WordGameState {

/// Kullanılabilir 8 harf listesi.
 List<String> get availableLetters;/// Kullanıcının yazdığı kelime tahmini.
 String get currentGuess;/// Joker kullanıldı mı?
 bool get jokerUsed;/// Joker hangi harf olarak kullanıldı?
 String? get jokerLetter;/// Her harfin kullanım durumu (UI için).
 List<LetterUse> get letterUsage;/// Oyun durumu.
 GameStatus get status;/// Kalan süre (saniye). Varsayılan 60 saniye.
 int get timeRemaining;/// Kazanılan puan (submit sonrası hesaplanır).
 int get score;/// Zaman bonusu (submit sonrası hesaplanır).
 int get timeBonus;/// Hata mesajı (geçersiz harf varsa).
 String? get validationError;/// Geçersiz harf pozisyonları (kırmızı gösterim için).
 List<int> get invalidLetterIndices;/// Harf seçimi tamamlandı mı? (8 harf seçildi mi)
 bool get lettersReady;/// Denenen kelimeler listesi.
 List<TriedWord> get triedWords;/// Seçili kelime indeksi (gönderilecek kelime).
 int? get selectedWordIndex;/// En iyi bulunan kelime (solver sonucu).
 String? get bestPossibleWord;
/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGameStateCopyWith<WordGameState> get copyWith => _$WordGameStateCopyWithImpl<WordGameState>(this as WordGameState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGameState&&const DeepCollectionEquality().equals(other.availableLetters, availableLetters)&&(identical(other.currentGuess, currentGuess) || other.currentGuess == currentGuess)&&(identical(other.jokerUsed, jokerUsed) || other.jokerUsed == jokerUsed)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter)&&const DeepCollectionEquality().equals(other.letterUsage, letterUsage)&&(identical(other.status, status) || other.status == status)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining)&&(identical(other.score, score) || other.score == score)&&(identical(other.timeBonus, timeBonus) || other.timeBonus == timeBonus)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&const DeepCollectionEquality().equals(other.invalidLetterIndices, invalidLetterIndices)&&(identical(other.lettersReady, lettersReady) || other.lettersReady == lettersReady)&&const DeepCollectionEquality().equals(other.triedWords, triedWords)&&(identical(other.selectedWordIndex, selectedWordIndex) || other.selectedWordIndex == selectedWordIndex)&&(identical(other.bestPossibleWord, bestPossibleWord) || other.bestPossibleWord == bestPossibleWord));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availableLetters),currentGuess,jokerUsed,jokerLetter,const DeepCollectionEquality().hash(letterUsage),status,timeRemaining,score,timeBonus,validationError,const DeepCollectionEquality().hash(invalidLetterIndices),lettersReady,const DeepCollectionEquality().hash(triedWords),selectedWordIndex,bestPossibleWord);

@override
String toString() {
  return 'WordGameState(availableLetters: $availableLetters, currentGuess: $currentGuess, jokerUsed: $jokerUsed, jokerLetter: $jokerLetter, letterUsage: $letterUsage, status: $status, timeRemaining: $timeRemaining, score: $score, timeBonus: $timeBonus, validationError: $validationError, invalidLetterIndices: $invalidLetterIndices, lettersReady: $lettersReady, triedWords: $triedWords, selectedWordIndex: $selectedWordIndex, bestPossibleWord: $bestPossibleWord)';
}


}

/// @nodoc
abstract mixin class $WordGameStateCopyWith<$Res>  {
  factory $WordGameStateCopyWith(WordGameState value, $Res Function(WordGameState) _then) = _$WordGameStateCopyWithImpl;
@useResult
$Res call({
 List<String> availableLetters, String currentGuess, bool jokerUsed, String? jokerLetter, List<LetterUse> letterUsage, GameStatus status, int timeRemaining, int score, int timeBonus, String? validationError, List<int> invalidLetterIndices, bool lettersReady, List<TriedWord> triedWords, int? selectedWordIndex, String? bestPossibleWord
});




}
/// @nodoc
class _$WordGameStateCopyWithImpl<$Res>
    implements $WordGameStateCopyWith<$Res> {
  _$WordGameStateCopyWithImpl(this._self, this._then);

  final WordGameState _self;
  final $Res Function(WordGameState) _then;

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableLetters = null,Object? currentGuess = null,Object? jokerUsed = null,Object? jokerLetter = freezed,Object? letterUsage = null,Object? status = null,Object? timeRemaining = null,Object? score = null,Object? timeBonus = null,Object? validationError = freezed,Object? invalidLetterIndices = null,Object? lettersReady = null,Object? triedWords = null,Object? selectedWordIndex = freezed,Object? bestPossibleWord = freezed,}) {
  return _then(_self.copyWith(
availableLetters: null == availableLetters ? _self.availableLetters : availableLetters // ignore: cast_nullable_to_non_nullable
as List<String>,currentGuess: null == currentGuess ? _self.currentGuess : currentGuess // ignore: cast_nullable_to_non_nullable
as String,jokerUsed: null == jokerUsed ? _self.jokerUsed : jokerUsed // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,letterUsage: null == letterUsage ? _self.letterUsage : letterUsage // ignore: cast_nullable_to_non_nullable
as List<LetterUse>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,timeRemaining: null == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,timeBonus: null == timeBonus ? _self.timeBonus : timeBonus // ignore: cast_nullable_to_non_nullable
as int,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,invalidLetterIndices: null == invalidLetterIndices ? _self.invalidLetterIndices : invalidLetterIndices // ignore: cast_nullable_to_non_nullable
as List<int>,lettersReady: null == lettersReady ? _self.lettersReady : lettersReady // ignore: cast_nullable_to_non_nullable
as bool,triedWords: null == triedWords ? _self.triedWords : triedWords // ignore: cast_nullable_to_non_nullable
as List<TriedWord>,selectedWordIndex: freezed == selectedWordIndex ? _self.selectedWordIndex : selectedWordIndex // ignore: cast_nullable_to_non_nullable
as int?,bestPossibleWord: freezed == bestPossibleWord ? _self.bestPossibleWord : bestPossibleWord // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordGameState].
extension WordGameStatePatterns on WordGameState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGameState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGameState value)  $default,){
final _that = this;
switch (_that) {
case _WordGameState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGameState value)?  $default,){
final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> availableLetters,  String currentGuess,  bool jokerUsed,  String? jokerLetter,  List<LetterUse> letterUsage,  GameStatus status,  int timeRemaining,  int score,  int timeBonus,  String? validationError,  List<int> invalidLetterIndices,  bool lettersReady,  List<TriedWord> triedWords,  int? selectedWordIndex,  String? bestPossibleWord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
return $default(_that.availableLetters,_that.currentGuess,_that.jokerUsed,_that.jokerLetter,_that.letterUsage,_that.status,_that.timeRemaining,_that.score,_that.timeBonus,_that.validationError,_that.invalidLetterIndices,_that.lettersReady,_that.triedWords,_that.selectedWordIndex,_that.bestPossibleWord);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> availableLetters,  String currentGuess,  bool jokerUsed,  String? jokerLetter,  List<LetterUse> letterUsage,  GameStatus status,  int timeRemaining,  int score,  int timeBonus,  String? validationError,  List<int> invalidLetterIndices,  bool lettersReady,  List<TriedWord> triedWords,  int? selectedWordIndex,  String? bestPossibleWord)  $default,) {final _that = this;
switch (_that) {
case _WordGameState():
return $default(_that.availableLetters,_that.currentGuess,_that.jokerUsed,_that.jokerLetter,_that.letterUsage,_that.status,_that.timeRemaining,_that.score,_that.timeBonus,_that.validationError,_that.invalidLetterIndices,_that.lettersReady,_that.triedWords,_that.selectedWordIndex,_that.bestPossibleWord);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> availableLetters,  String currentGuess,  bool jokerUsed,  String? jokerLetter,  List<LetterUse> letterUsage,  GameStatus status,  int timeRemaining,  int score,  int timeBonus,  String? validationError,  List<int> invalidLetterIndices,  bool lettersReady,  List<TriedWord> triedWords,  int? selectedWordIndex,  String? bestPossibleWord)?  $default,) {final _that = this;
switch (_that) {
case _WordGameState() when $default != null:
return $default(_that.availableLetters,_that.currentGuess,_that.jokerUsed,_that.jokerLetter,_that.letterUsage,_that.status,_that.timeRemaining,_that.score,_that.timeBonus,_that.validationError,_that.invalidLetterIndices,_that.lettersReady,_that.triedWords,_that.selectedWordIndex,_that.bestPossibleWord);case _:
  return null;

}
}

}

/// @nodoc


class _WordGameState extends WordGameState {
  const _WordGameState({required final  List<String> availableLetters, required this.currentGuess, required this.jokerUsed, this.jokerLetter, final  List<LetterUse> letterUsage = const [], this.status = GameStatus.notStarted, this.timeRemaining = 60, this.score = 0, this.timeBonus = 0, this.validationError, final  List<int> invalidLetterIndices = const [], this.lettersReady = false, final  List<TriedWord> triedWords = const [], this.selectedWordIndex, this.bestPossibleWord}): _availableLetters = availableLetters,_letterUsage = letterUsage,_invalidLetterIndices = invalidLetterIndices,_triedWords = triedWords,super._();
  

/// Kullanılabilir 8 harf listesi.
 final  List<String> _availableLetters;
/// Kullanılabilir 8 harf listesi.
@override List<String> get availableLetters {
  if (_availableLetters is EqualUnmodifiableListView) return _availableLetters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableLetters);
}

/// Kullanıcının yazdığı kelime tahmini.
@override final  String currentGuess;
/// Joker kullanıldı mı?
@override final  bool jokerUsed;
/// Joker hangi harf olarak kullanıldı?
@override final  String? jokerLetter;
/// Her harfin kullanım durumu (UI için).
 final  List<LetterUse> _letterUsage;
/// Her harfin kullanım durumu (UI için).
@override@JsonKey() List<LetterUse> get letterUsage {
  if (_letterUsage is EqualUnmodifiableListView) return _letterUsage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_letterUsage);
}

/// Oyun durumu.
@override@JsonKey() final  GameStatus status;
/// Kalan süre (saniye). Varsayılan 60 saniye.
@override@JsonKey() final  int timeRemaining;
/// Kazanılan puan (submit sonrası hesaplanır).
@override@JsonKey() final  int score;
/// Zaman bonusu (submit sonrası hesaplanır).
@override@JsonKey() final  int timeBonus;
/// Hata mesajı (geçersiz harf varsa).
@override final  String? validationError;
/// Geçersiz harf pozisyonları (kırmızı gösterim için).
 final  List<int> _invalidLetterIndices;
/// Geçersiz harf pozisyonları (kırmızı gösterim için).
@override@JsonKey() List<int> get invalidLetterIndices {
  if (_invalidLetterIndices is EqualUnmodifiableListView) return _invalidLetterIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invalidLetterIndices);
}

/// Harf seçimi tamamlandı mı? (8 harf seçildi mi)
@override@JsonKey() final  bool lettersReady;
/// Denenen kelimeler listesi.
 final  List<TriedWord> _triedWords;
/// Denenen kelimeler listesi.
@override@JsonKey() List<TriedWord> get triedWords {
  if (_triedWords is EqualUnmodifiableListView) return _triedWords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_triedWords);
}

/// Seçili kelime indeksi (gönderilecek kelime).
@override final  int? selectedWordIndex;
/// En iyi bulunan kelime (solver sonucu).
@override final  String? bestPossibleWord;

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGameStateCopyWith<_WordGameState> get copyWith => __$WordGameStateCopyWithImpl<_WordGameState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGameState&&const DeepCollectionEquality().equals(other._availableLetters, _availableLetters)&&(identical(other.currentGuess, currentGuess) || other.currentGuess == currentGuess)&&(identical(other.jokerUsed, jokerUsed) || other.jokerUsed == jokerUsed)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter)&&const DeepCollectionEquality().equals(other._letterUsage, _letterUsage)&&(identical(other.status, status) || other.status == status)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining)&&(identical(other.score, score) || other.score == score)&&(identical(other.timeBonus, timeBonus) || other.timeBonus == timeBonus)&&(identical(other.validationError, validationError) || other.validationError == validationError)&&const DeepCollectionEquality().equals(other._invalidLetterIndices, _invalidLetterIndices)&&(identical(other.lettersReady, lettersReady) || other.lettersReady == lettersReady)&&const DeepCollectionEquality().equals(other._triedWords, _triedWords)&&(identical(other.selectedWordIndex, selectedWordIndex) || other.selectedWordIndex == selectedWordIndex)&&(identical(other.bestPossibleWord, bestPossibleWord) || other.bestPossibleWord == bestPossibleWord));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableLetters),currentGuess,jokerUsed,jokerLetter,const DeepCollectionEquality().hash(_letterUsage),status,timeRemaining,score,timeBonus,validationError,const DeepCollectionEquality().hash(_invalidLetterIndices),lettersReady,const DeepCollectionEquality().hash(_triedWords),selectedWordIndex,bestPossibleWord);

@override
String toString() {
  return 'WordGameState(availableLetters: $availableLetters, currentGuess: $currentGuess, jokerUsed: $jokerUsed, jokerLetter: $jokerLetter, letterUsage: $letterUsage, status: $status, timeRemaining: $timeRemaining, score: $score, timeBonus: $timeBonus, validationError: $validationError, invalidLetterIndices: $invalidLetterIndices, lettersReady: $lettersReady, triedWords: $triedWords, selectedWordIndex: $selectedWordIndex, bestPossibleWord: $bestPossibleWord)';
}


}

/// @nodoc
abstract mixin class _$WordGameStateCopyWith<$Res> implements $WordGameStateCopyWith<$Res> {
  factory _$WordGameStateCopyWith(_WordGameState value, $Res Function(_WordGameState) _then) = __$WordGameStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> availableLetters, String currentGuess, bool jokerUsed, String? jokerLetter, List<LetterUse> letterUsage, GameStatus status, int timeRemaining, int score, int timeBonus, String? validationError, List<int> invalidLetterIndices, bool lettersReady, List<TriedWord> triedWords, int? selectedWordIndex, String? bestPossibleWord
});




}
/// @nodoc
class __$WordGameStateCopyWithImpl<$Res>
    implements _$WordGameStateCopyWith<$Res> {
  __$WordGameStateCopyWithImpl(this._self, this._then);

  final _WordGameState _self;
  final $Res Function(_WordGameState) _then;

/// Create a copy of WordGameState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableLetters = null,Object? currentGuess = null,Object? jokerUsed = null,Object? jokerLetter = freezed,Object? letterUsage = null,Object? status = null,Object? timeRemaining = null,Object? score = null,Object? timeBonus = null,Object? validationError = freezed,Object? invalidLetterIndices = null,Object? lettersReady = null,Object? triedWords = null,Object? selectedWordIndex = freezed,Object? bestPossibleWord = freezed,}) {
  return _then(_WordGameState(
availableLetters: null == availableLetters ? _self._availableLetters : availableLetters // ignore: cast_nullable_to_non_nullable
as List<String>,currentGuess: null == currentGuess ? _self.currentGuess : currentGuess // ignore: cast_nullable_to_non_nullable
as String,jokerUsed: null == jokerUsed ? _self.jokerUsed : jokerUsed // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,letterUsage: null == letterUsage ? _self._letterUsage : letterUsage // ignore: cast_nullable_to_non_nullable
as List<LetterUse>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,timeRemaining: null == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,timeBonus: null == timeBonus ? _self.timeBonus : timeBonus // ignore: cast_nullable_to_non_nullable
as int,validationError: freezed == validationError ? _self.validationError : validationError // ignore: cast_nullable_to_non_nullable
as String?,invalidLetterIndices: null == invalidLetterIndices ? _self._invalidLetterIndices : invalidLetterIndices // ignore: cast_nullable_to_non_nullable
as List<int>,lettersReady: null == lettersReady ? _self.lettersReady : lettersReady // ignore: cast_nullable_to_non_nullable
as bool,triedWords: null == triedWords ? _self._triedWords : triedWords // ignore: cast_nullable_to_non_nullable
as List<TriedWord>,selectedWordIndex: freezed == selectedWordIndex ? _self.selectedWordIndex : selectedWordIndex // ignore: cast_nullable_to_non_nullable
as int?,bestPossibleWord: freezed == bestPossibleWord ? _self.bestPossibleWord : bestPossibleWord // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TriedWord {

/// Kelime.
 String get word;/// Joker kullanıldı mı?
 bool get jokerUsed;/// Joker hangi harf olarak kullanıldı?
 String? get jokerLetter;/// Tahmini puan (harf sayısına göre).
 int get estimatedScore;
/// Create a copy of TriedWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TriedWordCopyWith<TriedWord> get copyWith => _$TriedWordCopyWithImpl<TriedWord>(this as TriedWord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriedWord&&(identical(other.word, word) || other.word == word)&&(identical(other.jokerUsed, jokerUsed) || other.jokerUsed == jokerUsed)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter)&&(identical(other.estimatedScore, estimatedScore) || other.estimatedScore == estimatedScore));
}


@override
int get hashCode => Object.hash(runtimeType,word,jokerUsed,jokerLetter,estimatedScore);

@override
String toString() {
  return 'TriedWord(word: $word, jokerUsed: $jokerUsed, jokerLetter: $jokerLetter, estimatedScore: $estimatedScore)';
}


}

/// @nodoc
abstract mixin class $TriedWordCopyWith<$Res>  {
  factory $TriedWordCopyWith(TriedWord value, $Res Function(TriedWord) _then) = _$TriedWordCopyWithImpl;
@useResult
$Res call({
 String word, bool jokerUsed, String? jokerLetter, int estimatedScore
});




}
/// @nodoc
class _$TriedWordCopyWithImpl<$Res>
    implements $TriedWordCopyWith<$Res> {
  _$TriedWordCopyWithImpl(this._self, this._then);

  final TriedWord _self;
  final $Res Function(TriedWord) _then;

/// Create a copy of TriedWord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? jokerUsed = null,Object? jokerLetter = freezed,Object? estimatedScore = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,jokerUsed: null == jokerUsed ? _self.jokerUsed : jokerUsed // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,estimatedScore: null == estimatedScore ? _self.estimatedScore : estimatedScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TriedWord].
extension TriedWordPatterns on TriedWord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TriedWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TriedWord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TriedWord value)  $default,){
final _that = this;
switch (_that) {
case _TriedWord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TriedWord value)?  $default,){
final _that = this;
switch (_that) {
case _TriedWord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  bool jokerUsed,  String? jokerLetter,  int estimatedScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TriedWord() when $default != null:
return $default(_that.word,_that.jokerUsed,_that.jokerLetter,_that.estimatedScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  bool jokerUsed,  String? jokerLetter,  int estimatedScore)  $default,) {final _that = this;
switch (_that) {
case _TriedWord():
return $default(_that.word,_that.jokerUsed,_that.jokerLetter,_that.estimatedScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  bool jokerUsed,  String? jokerLetter,  int estimatedScore)?  $default,) {final _that = this;
switch (_that) {
case _TriedWord() when $default != null:
return $default(_that.word,_that.jokerUsed,_that.jokerLetter,_that.estimatedScore);case _:
  return null;

}
}

}

/// @nodoc


class _TriedWord extends TriedWord {
  const _TriedWord({required this.word, required this.jokerUsed, this.jokerLetter, required this.estimatedScore}): super._();
  

/// Kelime.
@override final  String word;
/// Joker kullanıldı mı?
@override final  bool jokerUsed;
/// Joker hangi harf olarak kullanıldı?
@override final  String? jokerLetter;
/// Tahmini puan (harf sayısına göre).
@override final  int estimatedScore;

/// Create a copy of TriedWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriedWordCopyWith<_TriedWord> get copyWith => __$TriedWordCopyWithImpl<_TriedWord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriedWord&&(identical(other.word, word) || other.word == word)&&(identical(other.jokerUsed, jokerUsed) || other.jokerUsed == jokerUsed)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter)&&(identical(other.estimatedScore, estimatedScore) || other.estimatedScore == estimatedScore));
}


@override
int get hashCode => Object.hash(runtimeType,word,jokerUsed,jokerLetter,estimatedScore);

@override
String toString() {
  return 'TriedWord(word: $word, jokerUsed: $jokerUsed, jokerLetter: $jokerLetter, estimatedScore: $estimatedScore)';
}


}

/// @nodoc
abstract mixin class _$TriedWordCopyWith<$Res> implements $TriedWordCopyWith<$Res> {
  factory _$TriedWordCopyWith(_TriedWord value, $Res Function(_TriedWord) _then) = __$TriedWordCopyWithImpl;
@override @useResult
$Res call({
 String word, bool jokerUsed, String? jokerLetter, int estimatedScore
});




}
/// @nodoc
class __$TriedWordCopyWithImpl<$Res>
    implements _$TriedWordCopyWith<$Res> {
  __$TriedWordCopyWithImpl(this._self, this._then);

  final _TriedWord _self;
  final $Res Function(_TriedWord) _then;

/// Create a copy of TriedWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? jokerUsed = null,Object? jokerLetter = freezed,Object? estimatedScore = null,}) {
  return _then(_TriedWord(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,jokerUsed: null == jokerUsed ? _self.jokerUsed : jokerUsed // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,estimatedScore: null == estimatedScore ? _self.estimatedScore : estimatedScore // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LetterUse {

/// Harf karakteri.
 String get letter;/// Harf kullanıldı mı?
 bool get isUsed;/// Kelimedeki pozisyonu (kullanıldıysa).
 int? get positionInGuess;
/// Create a copy of LetterUse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LetterUseCopyWith<LetterUse> get copyWith => _$LetterUseCopyWithImpl<LetterUse>(this as LetterUse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LetterUse&&(identical(other.letter, letter) || other.letter == letter)&&(identical(other.isUsed, isUsed) || other.isUsed == isUsed)&&(identical(other.positionInGuess, positionInGuess) || other.positionInGuess == positionInGuess));
}


@override
int get hashCode => Object.hash(runtimeType,letter,isUsed,positionInGuess);

@override
String toString() {
  return 'LetterUse(letter: $letter, isUsed: $isUsed, positionInGuess: $positionInGuess)';
}


}

/// @nodoc
abstract mixin class $LetterUseCopyWith<$Res>  {
  factory $LetterUseCopyWith(LetterUse value, $Res Function(LetterUse) _then) = _$LetterUseCopyWithImpl;
@useResult
$Res call({
 String letter, bool isUsed, int? positionInGuess
});




}
/// @nodoc
class _$LetterUseCopyWithImpl<$Res>
    implements $LetterUseCopyWith<$Res> {
  _$LetterUseCopyWithImpl(this._self, this._then);

  final LetterUse _self;
  final $Res Function(LetterUse) _then;

/// Create a copy of LetterUse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? letter = null,Object? isUsed = null,Object? positionInGuess = freezed,}) {
  return _then(_self.copyWith(
letter: null == letter ? _self.letter : letter // ignore: cast_nullable_to_non_nullable
as String,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,positionInGuess: freezed == positionInGuess ? _self.positionInGuess : positionInGuess // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LetterUse].
extension LetterUsePatterns on LetterUse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LetterUse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LetterUse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LetterUse value)  $default,){
final _that = this;
switch (_that) {
case _LetterUse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LetterUse value)?  $default,){
final _that = this;
switch (_that) {
case _LetterUse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String letter,  bool isUsed,  int? positionInGuess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LetterUse() when $default != null:
return $default(_that.letter,_that.isUsed,_that.positionInGuess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String letter,  bool isUsed,  int? positionInGuess)  $default,) {final _that = this;
switch (_that) {
case _LetterUse():
return $default(_that.letter,_that.isUsed,_that.positionInGuess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String letter,  bool isUsed,  int? positionInGuess)?  $default,) {final _that = this;
switch (_that) {
case _LetterUse() when $default != null:
return $default(_that.letter,_that.isUsed,_that.positionInGuess);case _:
  return null;

}
}

}

/// @nodoc


class _LetterUse extends LetterUse {
  const _LetterUse({required this.letter, required this.isUsed, this.positionInGuess}): super._();
  

/// Harf karakteri.
@override final  String letter;
/// Harf kullanıldı mı?
@override final  bool isUsed;
/// Kelimedeki pozisyonu (kullanıldıysa).
@override final  int? positionInGuess;

/// Create a copy of LetterUse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LetterUseCopyWith<_LetterUse> get copyWith => __$LetterUseCopyWithImpl<_LetterUse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LetterUse&&(identical(other.letter, letter) || other.letter == letter)&&(identical(other.isUsed, isUsed) || other.isUsed == isUsed)&&(identical(other.positionInGuess, positionInGuess) || other.positionInGuess == positionInGuess));
}


@override
int get hashCode => Object.hash(runtimeType,letter,isUsed,positionInGuess);

@override
String toString() {
  return 'LetterUse(letter: $letter, isUsed: $isUsed, positionInGuess: $positionInGuess)';
}


}

/// @nodoc
abstract mixin class _$LetterUseCopyWith<$Res> implements $LetterUseCopyWith<$Res> {
  factory _$LetterUseCopyWith(_LetterUse value, $Res Function(_LetterUse) _then) = __$LetterUseCopyWithImpl;
@override @useResult
$Res call({
 String letter, bool isUsed, int? positionInGuess
});




}
/// @nodoc
class __$LetterUseCopyWithImpl<$Res>
    implements _$LetterUseCopyWith<$Res> {
  __$LetterUseCopyWithImpl(this._self, this._then);

  final _LetterUse _self;
  final $Res Function(_LetterUse) _then;

/// Create a copy of LetterUse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? letter = null,Object? isUsed = null,Object? positionInGuess = freezed,}) {
  return _then(_LetterUse(
letter: null == letter ? _self.letter : letter // ignore: cast_nullable_to_non_nullable
as String,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,positionInGuess: freezed == positionInGuess ? _self.positionInGuess : positionInGuess // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$WordValidationResult {

/// Doğrulama başarılı mı?
 bool get isValid;/// Doğrulanan kelime.
 String get word;/// Hata mesajı (geçersizse).
 String? get errorMessage;/// Geçersiz harf pozisyonları.
 List<int> get invalidLetterIndices;/// Joker kullanıldı mı?
 bool get jokerUsed;/// Joker hangi harf oldu?
 String? get jokerLetter;
/// Create a copy of WordValidationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordValidationResultCopyWith<WordValidationResult> get copyWith => _$WordValidationResultCopyWithImpl<WordValidationResult>(this as WordValidationResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordValidationResult&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.word, word) || other.word == word)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.invalidLetterIndices, invalidLetterIndices)&&(identical(other.jokerUsed, jokerUsed) || other.jokerUsed == jokerUsed)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter));
}


@override
int get hashCode => Object.hash(runtimeType,isValid,word,errorMessage,const DeepCollectionEquality().hash(invalidLetterIndices),jokerUsed,jokerLetter);

@override
String toString() {
  return 'WordValidationResult(isValid: $isValid, word: $word, errorMessage: $errorMessage, invalidLetterIndices: $invalidLetterIndices, jokerUsed: $jokerUsed, jokerLetter: $jokerLetter)';
}


}

/// @nodoc
abstract mixin class $WordValidationResultCopyWith<$Res>  {
  factory $WordValidationResultCopyWith(WordValidationResult value, $Res Function(WordValidationResult) _then) = _$WordValidationResultCopyWithImpl;
@useResult
$Res call({
 bool isValid, String word, String? errorMessage, List<int> invalidLetterIndices, bool jokerUsed, String? jokerLetter
});




}
/// @nodoc
class _$WordValidationResultCopyWithImpl<$Res>
    implements $WordValidationResultCopyWith<$Res> {
  _$WordValidationResultCopyWithImpl(this._self, this._then);

  final WordValidationResult _self;
  final $Res Function(WordValidationResult) _then;

/// Create a copy of WordValidationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isValid = null,Object? word = null,Object? errorMessage = freezed,Object? invalidLetterIndices = null,Object? jokerUsed = null,Object? jokerLetter = freezed,}) {
  return _then(_self.copyWith(
isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,invalidLetterIndices: null == invalidLetterIndices ? _self.invalidLetterIndices : invalidLetterIndices // ignore: cast_nullable_to_non_nullable
as List<int>,jokerUsed: null == jokerUsed ? _self.jokerUsed : jokerUsed // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordValidationResult].
extension WordValidationResultPatterns on WordValidationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordValidationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordValidationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordValidationResult value)  $default,){
final _that = this;
switch (_that) {
case _WordValidationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordValidationResult value)?  $default,){
final _that = this;
switch (_that) {
case _WordValidationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isValid,  String word,  String? errorMessage,  List<int> invalidLetterIndices,  bool jokerUsed,  String? jokerLetter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordValidationResult() when $default != null:
return $default(_that.isValid,_that.word,_that.errorMessage,_that.invalidLetterIndices,_that.jokerUsed,_that.jokerLetter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isValid,  String word,  String? errorMessage,  List<int> invalidLetterIndices,  bool jokerUsed,  String? jokerLetter)  $default,) {final _that = this;
switch (_that) {
case _WordValidationResult():
return $default(_that.isValid,_that.word,_that.errorMessage,_that.invalidLetterIndices,_that.jokerUsed,_that.jokerLetter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isValid,  String word,  String? errorMessage,  List<int> invalidLetterIndices,  bool jokerUsed,  String? jokerLetter)?  $default,) {final _that = this;
switch (_that) {
case _WordValidationResult() when $default != null:
return $default(_that.isValid,_that.word,_that.errorMessage,_that.invalidLetterIndices,_that.jokerUsed,_that.jokerLetter);case _:
  return null;

}
}

}

/// @nodoc


class _WordValidationResult extends WordValidationResult {
  const _WordValidationResult({required this.isValid, required this.word, this.errorMessage, final  List<int> invalidLetterIndices = const [], this.jokerUsed = false, this.jokerLetter}): _invalidLetterIndices = invalidLetterIndices,super._();
  

/// Doğrulama başarılı mı?
@override final  bool isValid;
/// Doğrulanan kelime.
@override final  String word;
/// Hata mesajı (geçersizse).
@override final  String? errorMessage;
/// Geçersiz harf pozisyonları.
 final  List<int> _invalidLetterIndices;
/// Geçersiz harf pozisyonları.
@override@JsonKey() List<int> get invalidLetterIndices {
  if (_invalidLetterIndices is EqualUnmodifiableListView) return _invalidLetterIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invalidLetterIndices);
}

/// Joker kullanıldı mı?
@override@JsonKey() final  bool jokerUsed;
/// Joker hangi harf oldu?
@override final  String? jokerLetter;

/// Create a copy of WordValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordValidationResultCopyWith<_WordValidationResult> get copyWith => __$WordValidationResultCopyWithImpl<_WordValidationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordValidationResult&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.word, word) || other.word == word)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._invalidLetterIndices, _invalidLetterIndices)&&(identical(other.jokerUsed, jokerUsed) || other.jokerUsed == jokerUsed)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter));
}


@override
int get hashCode => Object.hash(runtimeType,isValid,word,errorMessage,const DeepCollectionEquality().hash(_invalidLetterIndices),jokerUsed,jokerLetter);

@override
String toString() {
  return 'WordValidationResult(isValid: $isValid, word: $word, errorMessage: $errorMessage, invalidLetterIndices: $invalidLetterIndices, jokerUsed: $jokerUsed, jokerLetter: $jokerLetter)';
}


}

/// @nodoc
abstract mixin class _$WordValidationResultCopyWith<$Res> implements $WordValidationResultCopyWith<$Res> {
  factory _$WordValidationResultCopyWith(_WordValidationResult value, $Res Function(_WordValidationResult) _then) = __$WordValidationResultCopyWithImpl;
@override @useResult
$Res call({
 bool isValid, String word, String? errorMessage, List<int> invalidLetterIndices, bool jokerUsed, String? jokerLetter
});




}
/// @nodoc
class __$WordValidationResultCopyWithImpl<$Res>
    implements _$WordValidationResultCopyWith<$Res> {
  __$WordValidationResultCopyWithImpl(this._self, this._then);

  final _WordValidationResult _self;
  final $Res Function(_WordValidationResult) _then;

/// Create a copy of WordValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isValid = null,Object? word = null,Object? errorMessage = freezed,Object? invalidLetterIndices = null,Object? jokerUsed = null,Object? jokerLetter = freezed,}) {
  return _then(_WordValidationResult(
isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,invalidLetterIndices: null == invalidLetterIndices ? _self._invalidLetterIndices : invalidLetterIndices // ignore: cast_nullable_to_non_nullable
as List<int>,jokerUsed: null == jokerUsed ? _self.jokerUsed : jokerUsed // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$WordSolverResult {

/// Bulunan en iyi kelime.
 String get bestWord;/// Kelime puanı.
 int get score;/// Joker kullanıldı mı?
 bool get usesJoker;/// Joker hangi harf oldu?
 String? get jokerLetter;/// Joker kelimedeki pozisyonu.
 int? get jokerPosition;
/// Create a copy of WordSolverResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordSolverResultCopyWith<WordSolverResult> get copyWith => _$WordSolverResultCopyWithImpl<WordSolverResult>(this as WordSolverResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordSolverResult&&(identical(other.bestWord, bestWord) || other.bestWord == bestWord)&&(identical(other.score, score) || other.score == score)&&(identical(other.usesJoker, usesJoker) || other.usesJoker == usesJoker)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter)&&(identical(other.jokerPosition, jokerPosition) || other.jokerPosition == jokerPosition));
}


@override
int get hashCode => Object.hash(runtimeType,bestWord,score,usesJoker,jokerLetter,jokerPosition);

@override
String toString() {
  return 'WordSolverResult(bestWord: $bestWord, score: $score, usesJoker: $usesJoker, jokerLetter: $jokerLetter, jokerPosition: $jokerPosition)';
}


}

/// @nodoc
abstract mixin class $WordSolverResultCopyWith<$Res>  {
  factory $WordSolverResultCopyWith(WordSolverResult value, $Res Function(WordSolverResult) _then) = _$WordSolverResultCopyWithImpl;
@useResult
$Res call({
 String bestWord, int score, bool usesJoker, String? jokerLetter, int? jokerPosition
});




}
/// @nodoc
class _$WordSolverResultCopyWithImpl<$Res>
    implements $WordSolverResultCopyWith<$Res> {
  _$WordSolverResultCopyWithImpl(this._self, this._then);

  final WordSolverResult _self;
  final $Res Function(WordSolverResult) _then;

/// Create a copy of WordSolverResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bestWord = null,Object? score = null,Object? usesJoker = null,Object? jokerLetter = freezed,Object? jokerPosition = freezed,}) {
  return _then(_self.copyWith(
bestWord: null == bestWord ? _self.bestWord : bestWord // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,usesJoker: null == usesJoker ? _self.usesJoker : usesJoker // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,jokerPosition: freezed == jokerPosition ? _self.jokerPosition : jokerPosition // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordSolverResult].
extension WordSolverResultPatterns on WordSolverResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordSolverResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordSolverResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordSolverResult value)  $default,){
final _that = this;
switch (_that) {
case _WordSolverResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordSolverResult value)?  $default,){
final _that = this;
switch (_that) {
case _WordSolverResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bestWord,  int score,  bool usesJoker,  String? jokerLetter,  int? jokerPosition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordSolverResult() when $default != null:
return $default(_that.bestWord,_that.score,_that.usesJoker,_that.jokerLetter,_that.jokerPosition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bestWord,  int score,  bool usesJoker,  String? jokerLetter,  int? jokerPosition)  $default,) {final _that = this;
switch (_that) {
case _WordSolverResult():
return $default(_that.bestWord,_that.score,_that.usesJoker,_that.jokerLetter,_that.jokerPosition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bestWord,  int score,  bool usesJoker,  String? jokerLetter,  int? jokerPosition)?  $default,) {final _that = this;
switch (_that) {
case _WordSolverResult() when $default != null:
return $default(_that.bestWord,_that.score,_that.usesJoker,_that.jokerLetter,_that.jokerPosition);case _:
  return null;

}
}

}

/// @nodoc


class _WordSolverResult extends WordSolverResult {
  const _WordSolverResult({required this.bestWord, required this.score, required this.usesJoker, this.jokerLetter, this.jokerPosition}): super._();
  

/// Bulunan en iyi kelime.
@override final  String bestWord;
/// Kelime puanı.
@override final  int score;
/// Joker kullanıldı mı?
@override final  bool usesJoker;
/// Joker hangi harf oldu?
@override final  String? jokerLetter;
/// Joker kelimedeki pozisyonu.
@override final  int? jokerPosition;

/// Create a copy of WordSolverResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordSolverResultCopyWith<_WordSolverResult> get copyWith => __$WordSolverResultCopyWithImpl<_WordSolverResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordSolverResult&&(identical(other.bestWord, bestWord) || other.bestWord == bestWord)&&(identical(other.score, score) || other.score == score)&&(identical(other.usesJoker, usesJoker) || other.usesJoker == usesJoker)&&(identical(other.jokerLetter, jokerLetter) || other.jokerLetter == jokerLetter)&&(identical(other.jokerPosition, jokerPosition) || other.jokerPosition == jokerPosition));
}


@override
int get hashCode => Object.hash(runtimeType,bestWord,score,usesJoker,jokerLetter,jokerPosition);

@override
String toString() {
  return 'WordSolverResult(bestWord: $bestWord, score: $score, usesJoker: $usesJoker, jokerLetter: $jokerLetter, jokerPosition: $jokerPosition)';
}


}

/// @nodoc
abstract mixin class _$WordSolverResultCopyWith<$Res> implements $WordSolverResultCopyWith<$Res> {
  factory _$WordSolverResultCopyWith(_WordSolverResult value, $Res Function(_WordSolverResult) _then) = __$WordSolverResultCopyWithImpl;
@override @useResult
$Res call({
 String bestWord, int score, bool usesJoker, String? jokerLetter, int? jokerPosition
});




}
/// @nodoc
class __$WordSolverResultCopyWithImpl<$Res>
    implements _$WordSolverResultCopyWith<$Res> {
  __$WordSolverResultCopyWithImpl(this._self, this._then);

  final _WordSolverResult _self;
  final $Res Function(_WordSolverResult) _then;

/// Create a copy of WordSolverResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bestWord = null,Object? score = null,Object? usesJoker = null,Object? jokerLetter = freezed,Object? jokerPosition = freezed,}) {
  return _then(_WordSolverResult(
bestWord: null == bestWord ? _self.bestWord : bestWord // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,usesJoker: null == usesJoker ? _self.usesJoker : usesJoker // ignore: cast_nullable_to_non_nullable
as bool,jokerLetter: freezed == jokerLetter ? _self.jokerLetter : jokerLetter // ignore: cast_nullable_to_non_nullable
as String?,jokerPosition: freezed == jokerPosition ? _self.jokerPosition : jokerPosition // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
