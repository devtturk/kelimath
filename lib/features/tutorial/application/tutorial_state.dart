import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/domain.dart';

part 'tutorial_state.freezed.dart';

/// Tutorial durumu.
@freezed
abstract class TutorialState with _$TutorialState {
  const TutorialState._();

  const factory TutorialState({
    /// Tutorial'ın hangi aşamasında olduğu.
    required TutorialPhase phase,

    /// Mevcut adım index'i.
    required int currentStepIndex,

    /// Mevcut aşamadaki adımlar.
    required List<TutorialStep> steps,

    /// Tutorial atlandı mı?
    @Default(false) bool isSkipped,

    /// Tutorial tamamlandı mı?
    @Default(false) bool isCompleted,

    /// Kullanıcının yazdığı mevcut kelime (word phase için).
    @Default('') String currentWord,

    /// Mevcut sayılar (number phase için).
    @Default([]) List<int?> availableNumbers,

    /// Seçili sayı index'i.
    int? selectedNumberIndex,

    /// Seçili işlem.
    String? selectedOperation,

    /// İşlem geçmişi.
    @Default([]) List<String> operationHistory,
  }) = _TutorialState;

  /// Başlangıç durumu.
  factory TutorialState.initial() => TutorialState(
        phase: TutorialPhase.intro,
        currentStepIndex: 0,
        steps: [],
      );

  /// Kelime oyunu başlangıç durumu.
  factory TutorialState.wordPhase() => TutorialState(
        phase: TutorialPhase.word,
        currentStepIndex: 0,
        steps: TutorialScenario.wordSteps(),
      );

  /// Sayı oyunu başlangıç durumu.
  factory TutorialState.numberPhase() => TutorialState(
        phase: TutorialPhase.number,
        currentStepIndex: 0,
        steps: TutorialScenario.numberSteps(),
        availableNumbers: TutorialScenario.numberValues.cast<int?>(),
      );

  /// Mevcut adım.
  TutorialStep? get currentStep {
    if (currentStepIndex < 0 || currentStepIndex >= steps.length) {
      return null;
    }
    return steps[currentStepIndex];
  }

  /// Son adımda mı?
  bool get isLastStep => currentStepIndex >= steps.length - 1;

  /// İlerleme yüzdesi (0.0 - 1.0).
  double get progress {
    if (steps.isEmpty) return 0.0;
    return (currentStepIndex + 1) / steps.length;
  }

  /// Toplam ilerleme (her iki phase dahil).
  double get totalProgress {
    final wordSteps = TutorialScenario.wordStepCount;
    final numberSteps = TutorialScenario.numberStepCount;
    final total = wordSteps + numberSteps;

    if (phase == TutorialPhase.word) {
      return (currentStepIndex + 1) / total;
    } else if (phase == TutorialPhase.number) {
      return (wordSteps + currentStepIndex + 1) / total;
    }
    return 1.0;
  }
}
