import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutorial_step.freezed.dart';

/// Tutorial adım türleri.
enum TutorialAction {
  /// Bilgi göster (devam butonu ile geç).
  showInfo,

  /// Klavyeden harf seç.
  tapLetter,

  /// Harf rack'inden harf seç.
  tapLetterRack,

  /// "Ekle" butonuna bas.
  tapAddButton,

  /// "Gönder" butonuna bas.
  tapSubmitButton,

  /// Sayı seç.
  tapNumber,

  /// İşlem seç (+, -, ×, ÷).
  tapOperation,

  /// Geri al butonuna bas.
  tapUndoButton,

  /// Serbest kelime yazımı (kullanıcı istediği gibi yazar).
  freeTypeWord,

  /// Serbest sayı işlemi (kullanıcı istediği gibi işlem yapar).
  freeNumberOperation,
}

/// Tutorial'ın hangi aşamasında olduğu.
enum TutorialPhase {
  /// Başlangıç (intro).
  intro,

  /// Kelime oyunu demosu.
  word,

  /// Sayı oyunu demosu.
  number,

  /// Tamamlandı.
  completed,
}

/// Bir tutorial adımını temsil eder.
@freezed
abstract class TutorialStep with _$TutorialStep {
  const factory TutorialStep({
    /// Adım numarası (görsel gösterim için).
    required int stepNumber,

    /// Kullanıcıya gösterilecek talimat.
    required String instruction,

    /// Bu adımda beklenen aksiyon.
    required TutorialAction action,

    /// Hedef tuş (tapLetter için, örn: "K").
    String? targetKey,

    /// Hedef index (tapNumber, tapLetterRack için).
    int? targetIndex,

    /// Hedef işlem (+, -, ×, ÷) string olarak.
    String? targetOperation,

    /// Tooltip'in ekranda nereye konumlanacağı (top/bottom).
    @Default(TooltipPosition.bottom) TooltipPosition tooltipPosition,
  }) = _TutorialStep;
}

/// Tooltip pozisyonu.
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}
