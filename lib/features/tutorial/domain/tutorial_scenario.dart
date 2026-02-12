import 'tutorial_step.dart';

/// Tutorial senaryolarını içeren statik sınıf.
class TutorialScenario {
  TutorialScenario._();

  // =============================================
  // KELIME OYUNU SENARYOSU
  // =============================================

  /// Kelime oyunu için sabit harfler.
  static const List<String> wordLetters = [
    'K',
    'E',
    'L',
    'İ',
    'M',
    'A',
    'S',
    'T'
  ];

  /// Hedef kelime.
  static const String targetWord = 'KELİME';

  /// Kelime oyunu demo adımları - Sadeleştirilmiş.
  static List<TutorialStep> wordSteps() => [
        // Adım 1: Tanıtım
        const TutorialStep(
          stepNumber: 1,
          instruction:
              'Bu senin 8 harfin.\nBu harflerle anlamlı kelimeler yazacaksın.',
          action: TutorialAction.showInfo,
          tooltipPosition: TooltipPosition.bottom,
        ),
        // Adım 2: Kelime yaz (serbest)
        const TutorialStep(
          stepNumber: 2,
          instruction: 'Şimdi "KELİME" yaz',
          action: TutorialAction.freeTypeWord,
          targetKey: 'KELİME', // Hedef kelime
          tooltipPosition: TooltipPosition.top,
        ),
        // Adım 3: Ekle butonu
        const TutorialStep(
          stepNumber: 3,
          instruction: 'Kelimeyi listeye ekle',
          action: TutorialAction.tapAddButton,
          tooltipPosition: TooltipPosition.top,
        ),
        // Adım 4: Gönder butonu
        const TutorialStep(
          stepNumber: 4,
          instruction: 'Cevabını gönder',
          action: TutorialAction.tapSubmitButton,
          tooltipPosition: TooltipPosition.top,
        ),
      ];

  /// Kelime oyunu toplam adım sayısı.
  static int get wordStepCount => wordSteps().length;

  // =============================================
  // SAYI OYUNU SENARYOSU
  // =============================================

  /// Sayı oyunu için sabit sayılar.
  static const List<int> numberValues = [25, 10, 5, 3, 2, 1];

  /// Hedef sayı.
  static const int targetNumber = 100;

  /// Sayı oyunu demo adımları - Sadeleştirilmiş.
  /// İpucu: 3 + 1 = 4, sonra 25 × 4 = 100
  static List<TutorialStep> numberSteps() => [
        // Adım 1: Tanıtım
        const TutorialStep(
          stepNumber: 1,
          instruction:
              'Hedef sayıya ulaşmaya çalış!\n+, -, ×, ÷ işlemlerini kullanabilirsin.',
          action: TutorialAction.showInfo,
          tooltipPosition: TooltipPosition.bottom,
        ),
        // Adım 2: Serbest işlem
        const TutorialStep(
          stepNumber: 2,
          instruction: 'İpucu: 3+1=4, sonra 25×4=100',
          action: TutorialAction.freeNumberOperation,
          tooltipPosition: TooltipPosition.top,
        ),
        // Adım 3: Gönder
        const TutorialStep(
          stepNumber: 3,
          instruction: 'Sonucu gönder',
          action: TutorialAction.tapSubmitButton,
          tooltipPosition: TooltipPosition.top,
        ),
      ];

  /// Sayı oyunu toplam adım sayısı.
  static int get numberStepCount => numberSteps().length;

  /// Toplam adım sayısı (kelime + sayı).
  static int get totalStepCount => wordStepCount + numberStepCount;
}
