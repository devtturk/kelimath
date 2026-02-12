import 'package:freezed_annotation/freezed_annotation.dart';

// Number Game'den GameStatus'u import ediyoruz (ortak kullanım)
import '../../number_game/domain/number_game_state.dart' show GameStatus;

part 'word_game_state.freezed.dart';

/// Kelime oyununun tüm durumunu temsil eden immutable state sınıfı.
@freezed
abstract class WordGameState with _$WordGameState {
  const WordGameState._();

  const factory WordGameState({
    /// Kullanılabilir 8 harf listesi.
    required List<String> availableLetters,

    /// Kullanıcının yazdığı kelime tahmini.
    required String currentGuess,

    /// Joker kullanıldı mı?
    required bool jokerUsed,

    /// Joker hangi harf olarak kullanıldı?
    String? jokerLetter,

    /// Her harfin kullanım durumu (UI için).
    @Default([]) List<LetterUse> letterUsage,

    /// Oyun durumu.
    @Default(GameStatus.notStarted) GameStatus status,

    /// Kalan süre (saniye). Varsayılan 60 saniye.
    @Default(60) int timeRemaining,

    /// Kazanılan puan (submit sonrası hesaplanır).
    @Default(0) int score,

    /// Zaman bonusu (submit sonrası hesaplanır).
    @Default(0) int timeBonus,

    /// Hata mesajı (geçersiz harf varsa).
    String? validationError,

    /// Geçersiz harf pozisyonları (kırmızı gösterim için).
    @Default([]) List<int> invalidLetterIndices,

    /// Harf seçimi tamamlandı mı? (8 harf seçildi mi)
    @Default(false) bool lettersReady,

    /// Denenen kelimeler listesi.
    @Default([]) List<TriedWord> triedWords,

    /// Seçili kelime indeksi (gönderilecek kelime).
    int? selectedWordIndex,

    /// En iyi bulunan kelime (solver sonucu).
    String? bestPossibleWord,
  }) = _WordGameState;

  /// Joker kullanılabilir mi?
  bool get hasJoker => !jokerUsed;

  /// Oyun oynama durumunda mı?
  bool get isPlaying => status == GameStatus.playing;

  /// Mevcut kelime listeye eklenebilir mi?
  bool get canAddWord =>
      status == GameStatus.playing &&
      currentGuess.length >= 3 &&
      validationError == null &&
      invalidLetterIndices.isEmpty &&
      lettersReady;

  /// Kelime gönderilebilir mi? (en az bir kelime seçili olmalı)
  bool get canSubmit =>
      status == GameStatus.playing &&
      lettersReady &&
      (selectedWordIndex != null || canAddWord);

  /// Seçili kelime.
  TriedWord? get selectedWord =>
      selectedWordIndex != null && selectedWordIndex! < triedWords.length
          ? triedWords[selectedWordIndex!]
          : null;

  /// Gönderilecek kelime (seçili veya mevcut).
  String get wordToSubmit {
    if (selectedWordIndex != null && selectedWordIndex! < triedWords.length) {
      return triedWords[selectedWordIndex!].word;
    }
    return currentGuess;
  }

  /// Toplam puan (kelime puanı + zaman bonusu).
  int get totalScore => score + timeBonus;

  /// Tahmin uzunluğu (joker dahil).
  int get guessLength => currentGuess.length;

  /// 9 harfli tam kelime mi? (8 harf + joker)
  bool get isFullWord => guessLength == 9 && jokerUsed;

  /// Oyun gönderildi mi?
  bool get isSubmitted =>
      status == GameStatus.submitted || status == GameStatus.completed;

  /// Kalan harf sayısı (seçilecek).
  int get remainingLetterCount => 8 - availableLetters.length;

  /// Harf seçimi başladı mı?
  bool get hasStartedSelection => availableLetters.isNotEmpty;

  /// Denenen kelime sayısı.
  int get triedWordCount => triedWords.length;
}

/// Denenen kelime modeli.
@freezed
abstract class TriedWord with _$TriedWord {
  const TriedWord._();

  const factory TriedWord({
    /// Kelime.
    required String word,

    /// Joker kullanıldı mı?
    required bool jokerUsed,

    /// Joker hangi harf olarak kullanıldı?
    String? jokerLetter,

    /// Tahmini puan (harf sayısına göre).
    required int estimatedScore,
  }) = _TriedWord;

  /// Harf sayısı.
  int get letterCount => word.length;
}

/// Harf kullanım durumu (UI için).
@freezed
abstract class LetterUse with _$LetterUse {
  const LetterUse._();

  const factory LetterUse({
    /// Harf karakteri.
    required String letter,

    /// Harf kullanıldı mı?
    required bool isUsed,

    /// Kelimedeki pozisyonu (kullanıldıysa).
    int? positionInGuess,
  }) = _LetterUse;
}

/// Kelime doğrulama sonucu.
@freezed
abstract class WordValidationResult with _$WordValidationResult {
  const WordValidationResult._();

  const factory WordValidationResult({
    /// Doğrulama başarılı mı?
    required bool isValid,

    /// Doğrulanan kelime.
    required String word,

    /// Hata mesajı (geçersizse).
    String? errorMessage,

    /// Geçersiz harf pozisyonları.
    @Default([]) List<int> invalidLetterIndices,

    /// Joker kullanıldı mı?
    @Default(false) bool jokerUsed,

    /// Joker hangi harf oldu?
    String? jokerLetter,
  }) = _WordValidationResult;
}

/// Solver sonucu (en iyi kelime).
@freezed
abstract class WordSolverResult with _$WordSolverResult {
  const WordSolverResult._();

  const factory WordSolverResult({
    /// Bulunan en iyi kelime.
    required String bestWord,

    /// Kelime puanı.
    required int score,

    /// Joker kullanıldı mı?
    required bool usesJoker,

    /// Joker hangi harf oldu?
    String? jokerLetter,

    /// Joker kelimedeki pozisyonu.
    int? jokerPosition,
  }) = _WordSolverResult;

  /// Kelime bulundu mu?
  bool get hasWord => bestWord.isNotEmpty;
}
