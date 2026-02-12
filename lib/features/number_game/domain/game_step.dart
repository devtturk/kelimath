import 'package:freezed_annotation/freezed_annotation.dart';

import 'operation.dart';

part 'game_step.freezed.dart';

/// Oyunda yapılan tek bir işlem adımını temsil eder.
/// Undo işlemi ve adım geçmişi için kullanılır.
@freezed
abstract class GameStep with _$GameStep {
  const factory GameStep({
    /// İşlemde kullanılan ilk sayı.
    required int firstNumber,

    /// İşlemde kullanılan ikinci sayı.
    required int secondNumber,

    /// Uygulanan işlem türü.
    required Operation operation,

    /// İşlemin sonucu.
    required int result,

    /// İşlem öncesi availableNumbers listesinin kopyası (undo için).
    required List<int> previousAvailableNumbers,
  }) = _GameStep;
}
