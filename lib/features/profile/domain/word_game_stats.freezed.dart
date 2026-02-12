// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_game_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordGameStats {

/// Oynanan oyun sayısı.
 int get gamesPlayed;/// Toplam kazanılan puan.
 int get totalScore;/// En yüksek tek oyun puanı.
 int get highScore;/// Toplam bulunan kelime sayısı.
 int get totalWordsFound;/// En uzun kelimenin harf sayısı.
 int get longestWord;/// En iyi bulunan kelime.
 String get bestWord;/// 9 harfli tam kelime bonusu sayısı.
 int get fullWordBonusCount;/// Mükemmel round sayısı (maksimum puan).
 int get perfectRounds;/// Kelime uzunluğu dağılımı (uzunluk -> sayı).
 Map<String, int> get wordLengthDistribution;
/// Create a copy of WordGameStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGameStatsCopyWith<WordGameStats> get copyWith => _$WordGameStatsCopyWithImpl<WordGameStats>(this as WordGameStats, _$identity);

  /// Serializes this WordGameStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGameStats&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.totalWordsFound, totalWordsFound) || other.totalWordsFound == totalWordsFound)&&(identical(other.longestWord, longestWord) || other.longestWord == longestWord)&&(identical(other.bestWord, bestWord) || other.bestWord == bestWord)&&(identical(other.fullWordBonusCount, fullWordBonusCount) || other.fullWordBonusCount == fullWordBonusCount)&&(identical(other.perfectRounds, perfectRounds) || other.perfectRounds == perfectRounds)&&const DeepCollectionEquality().equals(other.wordLengthDistribution, wordLengthDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesPlayed,totalScore,highScore,totalWordsFound,longestWord,bestWord,fullWordBonusCount,perfectRounds,const DeepCollectionEquality().hash(wordLengthDistribution));

@override
String toString() {
  return 'WordGameStats(gamesPlayed: $gamesPlayed, totalScore: $totalScore, highScore: $highScore, totalWordsFound: $totalWordsFound, longestWord: $longestWord, bestWord: $bestWord, fullWordBonusCount: $fullWordBonusCount, perfectRounds: $perfectRounds, wordLengthDistribution: $wordLengthDistribution)';
}


}

/// @nodoc
abstract mixin class $WordGameStatsCopyWith<$Res>  {
  factory $WordGameStatsCopyWith(WordGameStats value, $Res Function(WordGameStats) _then) = _$WordGameStatsCopyWithImpl;
@useResult
$Res call({
 int gamesPlayed, int totalScore, int highScore, int totalWordsFound, int longestWord, String bestWord, int fullWordBonusCount, int perfectRounds, Map<String, int> wordLengthDistribution
});




}
/// @nodoc
class _$WordGameStatsCopyWithImpl<$Res>
    implements $WordGameStatsCopyWith<$Res> {
  _$WordGameStatsCopyWithImpl(this._self, this._then);

  final WordGameStats _self;
  final $Res Function(WordGameStats) _then;

/// Create a copy of WordGameStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gamesPlayed = null,Object? totalScore = null,Object? highScore = null,Object? totalWordsFound = null,Object? longestWord = null,Object? bestWord = null,Object? fullWordBonusCount = null,Object? perfectRounds = null,Object? wordLengthDistribution = null,}) {
  return _then(_self.copyWith(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,totalWordsFound: null == totalWordsFound ? _self.totalWordsFound : totalWordsFound // ignore: cast_nullable_to_non_nullable
as int,longestWord: null == longestWord ? _self.longestWord : longestWord // ignore: cast_nullable_to_non_nullable
as int,bestWord: null == bestWord ? _self.bestWord : bestWord // ignore: cast_nullable_to_non_nullable
as String,fullWordBonusCount: null == fullWordBonusCount ? _self.fullWordBonusCount : fullWordBonusCount // ignore: cast_nullable_to_non_nullable
as int,perfectRounds: null == perfectRounds ? _self.perfectRounds : perfectRounds // ignore: cast_nullable_to_non_nullable
as int,wordLengthDistribution: null == wordLengthDistribution ? _self.wordLengthDistribution : wordLengthDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [WordGameStats].
extension WordGameStatsPatterns on WordGameStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGameStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGameStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGameStats value)  $default,){
final _that = this;
switch (_that) {
case _WordGameStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGameStats value)?  $default,){
final _that = this;
switch (_that) {
case _WordGameStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gamesPlayed,  int totalScore,  int highScore,  int totalWordsFound,  int longestWord,  String bestWord,  int fullWordBonusCount,  int perfectRounds,  Map<String, int> wordLengthDistribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGameStats() when $default != null:
return $default(_that.gamesPlayed,_that.totalScore,_that.highScore,_that.totalWordsFound,_that.longestWord,_that.bestWord,_that.fullWordBonusCount,_that.perfectRounds,_that.wordLengthDistribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gamesPlayed,  int totalScore,  int highScore,  int totalWordsFound,  int longestWord,  String bestWord,  int fullWordBonusCount,  int perfectRounds,  Map<String, int> wordLengthDistribution)  $default,) {final _that = this;
switch (_that) {
case _WordGameStats():
return $default(_that.gamesPlayed,_that.totalScore,_that.highScore,_that.totalWordsFound,_that.longestWord,_that.bestWord,_that.fullWordBonusCount,_that.perfectRounds,_that.wordLengthDistribution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gamesPlayed,  int totalScore,  int highScore,  int totalWordsFound,  int longestWord,  String bestWord,  int fullWordBonusCount,  int perfectRounds,  Map<String, int> wordLengthDistribution)?  $default,) {final _that = this;
switch (_that) {
case _WordGameStats() when $default != null:
return $default(_that.gamesPlayed,_that.totalScore,_that.highScore,_that.totalWordsFound,_that.longestWord,_that.bestWord,_that.fullWordBonusCount,_that.perfectRounds,_that.wordLengthDistribution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordGameStats extends WordGameStats {
  const _WordGameStats({required this.gamesPlayed, required this.totalScore, required this.highScore, required this.totalWordsFound, required this.longestWord, required this.bestWord, required this.fullWordBonusCount, required this.perfectRounds, final  Map<String, int> wordLengthDistribution = const {}}): _wordLengthDistribution = wordLengthDistribution,super._();
  factory _WordGameStats.fromJson(Map<String, dynamic> json) => _$WordGameStatsFromJson(json);

/// Oynanan oyun sayısı.
@override final  int gamesPlayed;
/// Toplam kazanılan puan.
@override final  int totalScore;
/// En yüksek tek oyun puanı.
@override final  int highScore;
/// Toplam bulunan kelime sayısı.
@override final  int totalWordsFound;
/// En uzun kelimenin harf sayısı.
@override final  int longestWord;
/// En iyi bulunan kelime.
@override final  String bestWord;
/// 9 harfli tam kelime bonusu sayısı.
@override final  int fullWordBonusCount;
/// Mükemmel round sayısı (maksimum puan).
@override final  int perfectRounds;
/// Kelime uzunluğu dağılımı (uzunluk -> sayı).
 final  Map<String, int> _wordLengthDistribution;
/// Kelime uzunluğu dağılımı (uzunluk -> sayı).
@override@JsonKey() Map<String, int> get wordLengthDistribution {
  if (_wordLengthDistribution is EqualUnmodifiableMapView) return _wordLengthDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_wordLengthDistribution);
}


/// Create a copy of WordGameStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGameStatsCopyWith<_WordGameStats> get copyWith => __$WordGameStatsCopyWithImpl<_WordGameStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordGameStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGameStats&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.highScore, highScore) || other.highScore == highScore)&&(identical(other.totalWordsFound, totalWordsFound) || other.totalWordsFound == totalWordsFound)&&(identical(other.longestWord, longestWord) || other.longestWord == longestWord)&&(identical(other.bestWord, bestWord) || other.bestWord == bestWord)&&(identical(other.fullWordBonusCount, fullWordBonusCount) || other.fullWordBonusCount == fullWordBonusCount)&&(identical(other.perfectRounds, perfectRounds) || other.perfectRounds == perfectRounds)&&const DeepCollectionEquality().equals(other._wordLengthDistribution, _wordLengthDistribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gamesPlayed,totalScore,highScore,totalWordsFound,longestWord,bestWord,fullWordBonusCount,perfectRounds,const DeepCollectionEquality().hash(_wordLengthDistribution));

@override
String toString() {
  return 'WordGameStats(gamesPlayed: $gamesPlayed, totalScore: $totalScore, highScore: $highScore, totalWordsFound: $totalWordsFound, longestWord: $longestWord, bestWord: $bestWord, fullWordBonusCount: $fullWordBonusCount, perfectRounds: $perfectRounds, wordLengthDistribution: $wordLengthDistribution)';
}


}

/// @nodoc
abstract mixin class _$WordGameStatsCopyWith<$Res> implements $WordGameStatsCopyWith<$Res> {
  factory _$WordGameStatsCopyWith(_WordGameStats value, $Res Function(_WordGameStats) _then) = __$WordGameStatsCopyWithImpl;
@override @useResult
$Res call({
 int gamesPlayed, int totalScore, int highScore, int totalWordsFound, int longestWord, String bestWord, int fullWordBonusCount, int perfectRounds, Map<String, int> wordLengthDistribution
});




}
/// @nodoc
class __$WordGameStatsCopyWithImpl<$Res>
    implements _$WordGameStatsCopyWith<$Res> {
  __$WordGameStatsCopyWithImpl(this._self, this._then);

  final _WordGameStats _self;
  final $Res Function(_WordGameStats) _then;

/// Create a copy of WordGameStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gamesPlayed = null,Object? totalScore = null,Object? highScore = null,Object? totalWordsFound = null,Object? longestWord = null,Object? bestWord = null,Object? fullWordBonusCount = null,Object? perfectRounds = null,Object? wordLengthDistribution = null,}) {
  return _then(_WordGameStats(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,highScore: null == highScore ? _self.highScore : highScore // ignore: cast_nullable_to_non_nullable
as int,totalWordsFound: null == totalWordsFound ? _self.totalWordsFound : totalWordsFound // ignore: cast_nullable_to_non_nullable
as int,longestWord: null == longestWord ? _self.longestWord : longestWord // ignore: cast_nullable_to_non_nullable
as int,bestWord: null == bestWord ? _self.bestWord : bestWord // ignore: cast_nullable_to_non_nullable
as String,fullWordBonusCount: null == fullWordBonusCount ? _self.fullWordBonusCount : fullWordBonusCount // ignore: cast_nullable_to_non_nullable
as int,perfectRounds: null == perfectRounds ? _self.perfectRounds : perfectRounds // ignore: cast_nullable_to_non_nullable
as int,wordLengthDistribution: null == wordLengthDistribution ? _self._wordLengthDistribution : wordLengthDistribution // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
