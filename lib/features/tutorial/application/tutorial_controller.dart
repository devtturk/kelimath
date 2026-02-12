import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/application/application.dart';
import '../domain/domain.dart';
import 'tutorial_state.dart';

/// Tutorial controller.
class TutorialController extends Notifier<TutorialState> {
  @override
  TutorialState build() {
    return TutorialState.initial();
  }

  /// Tutorial'ı kelime oyunu ile başlat.
  void startWordTutorial() {
    state = TutorialState.wordPhase();
  }

  /// Tutorial'ı sayı oyunu ile başlat.
  void startNumberTutorial() {
    state = TutorialState.numberPhase();
  }

  /// Mevcut adımı tamamla ve sonrakine geç.
  void completeStep() {
    if (state.isLastStep) {
      // Son adım tamamlandı
      if (state.phase == TutorialPhase.word) {
        // Kelime oyunu bitti, sayı oyununa geç
        state = TutorialState.numberPhase();
      } else {
        // Tüm tutorial tamamlandı
        _finishTutorial();
      }
    } else {
      // Sonraki adıma geç
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex + 1,
      );
    }
  }

  /// Kelime güncelle (word phase için).
  void updateWord(String word) {
    state = state.copyWith(currentWord: word);
  }

  /// Harf ekle.
  void addLetter(String letter) {
    state = state.copyWith(currentWord: state.currentWord + letter);
  }

  /// Son harfi sil.
  void removeLetter() {
    if (state.currentWord.isNotEmpty) {
      state = state.copyWith(
        currentWord: state.currentWord.substring(0, state.currentWord.length - 1),
      );
    }
  }

  /// Kelimeyi temizle.
  void clearWord() {
    state = state.copyWith(currentWord: '');
  }

  /// Sayı seç (number phase için).
  void selectNumber(int index) {
    state = state.copyWith(selectedNumberIndex: index);
  }

  /// İşlem seç.
  void selectOperation(String operation) {
    state = state.copyWith(selectedOperation: operation);
  }

  /// İşlemi uygula.
  void applyOperation(int secondIndex) {
    final firstIndex = state.selectedNumberIndex;
    final operation = state.selectedOperation;

    if (firstIndex == null || operation == null) return;

    final numbers = List<int?>.from(state.availableNumbers);
    final first = numbers[firstIndex];
    final second = numbers[secondIndex];

    if (first == null || second == null) return;

    int? result;
    String operationStr = '';

    switch (operation) {
      case '+':
        result = first + second;
        operationStr = '$first + $second = $result';
        break;
      case '-':
        if (first > second) {
          result = first - second;
          operationStr = '$first - $second = $result';
        } else {
          result = second - first;
          operationStr = '$second - $first = $result';
        }
        break;
      case '×':
        result = first * second;
        operationStr = '$first × $second = $result';
        break;
      case '÷':
        if (second != 0 && first % second == 0) {
          result = first ~/ second;
          operationStr = '$first ÷ $second = $result';
        } else if (first != 0 && second % first == 0) {
          result = second ~/ first;
          operationStr = '$second ÷ $first = $result';
        }
        break;
    }

    if (result != null) {
      // Kullanılan sayıları kaldır ve sonucu ekle
      numbers[firstIndex] = null;
      numbers[secondIndex] = null;

      // Sonucu boş bir slota ekle
      final emptyIndex = numbers.indexWhere((n) => n == null);
      if (emptyIndex != -1) {
        numbers[emptyIndex] = result;
      }

      state = state.copyWith(
        availableNumbers: numbers,
        selectedNumberIndex: null,
        selectedOperation: null,
        operationHistory: [...state.operationHistory, operationStr],
      );
    }
  }

  /// Seçimi temizle.
  void clearSelection() {
    state = state.copyWith(
      selectedNumberIndex: null,
      selectedOperation: null,
    );
  }

  /// Mevcut aksiyonun geçerli olup olmadığını kontrol et.
  bool isValidAction(TutorialAction action, {String? key, int? index, String? operation}) {
    final step = state.currentStep;
    if (step == null) return false;

    // Aksiyon türü eşleşmeli
    if (step.action != action) return false;

    // Spesifik kontroller
    switch (action) {
      case TutorialAction.tapLetter:
        return step.targetKey == key;
      case TutorialAction.tapNumber:
        // Number phase'de index kontrolü
        if (state.phase == TutorialPhase.number) {
          // İlk işlem için (3+1): index 3 ve 5
          // İkinci işlem için (25×4): index değişiyor
          return _isValidNumberTap(index);
        }
        return step.targetIndex == index;
      case TutorialAction.tapOperation:
        return step.targetOperation == operation;
      case TutorialAction.showInfo:
      case TutorialAction.tapAddButton:
      case TutorialAction.tapSubmitButton:
      case TutorialAction.tapLetterRack:
      case TutorialAction.tapUndoButton:
      case TutorialAction.freeTypeWord:
      case TutorialAction.freeNumberOperation:
        return true;
    }
  }

  /// Sayı seçiminin geçerli olup olmadığını kontrol et.
  bool _isValidNumberTap(int? tappedIndex) {
    if (tappedIndex == null) return false;

    final step = state.currentStep;
    if (step == null) return false;

    // Mevcut sayılar
    final numbers = state.availableNumbers;

    // Adım 3: 3'ü seç (başlangıç listesinde index 3)
    if (step.stepNumber == 3) {
      // 3 sayısını bul
      return numbers[tappedIndex] == 3;
    }

    // Adım 5: 1'i seç (başlangıç listesinde index 5)
    if (step.stepNumber == 5) {
      return numbers[tappedIndex] == 1;
    }

    // Adım 6: 25'i seç
    if (step.stepNumber == 6) {
      return numbers[tappedIndex] == 25;
    }

    // Adım 8: 4'ü seç (yeni oluşan sayı)
    if (step.stepNumber == 8) {
      return numbers[tappedIndex] == 4;
    }

    return false;
  }

  /// Tutorial'ı atla.
  void skipTutorial() {
    state = state.copyWith(isSkipped: true);
    _finishTutorial();
  }

  /// Tutorial'ı tamamla (public - bitiş ekranından çağrılır).
  void finishTutorial() {
    _finishTutorial();
  }

  /// Tutorial'ı tamamla (internal).
  void _finishTutorial() {
    state = state.copyWith(
      phase: TutorialPhase.completed,
      isCompleted: true,
    );

    // Profili güncelle
    _markTutorialCompleted();
  }

  /// Profilde tutorial tamamlandı olarak işaretle.
  void _markTutorialCompleted() {
    final profileNotifier = ref.read(userProfileProvider.notifier);
    profileNotifier.completeTutorial();
  }

  /// Tutorial'ı sıfırla.
  void reset() {
    state = TutorialState.initial();
  }
}

/// Tutorial controller provider.
final tutorialControllerProvider =
    NotifierProvider<TutorialController, TutorialState>(
  TutorialController.new,
);
