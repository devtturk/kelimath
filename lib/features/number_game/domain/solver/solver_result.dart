import 'package:freezed_annotation/freezed_annotation.dart';

part 'solver_result.freezed.dart';

/// Solver'ın bulduğu en iyi çözümü temsil eder.
@freezed
abstract class SolverResult with _$SolverResult {
  const SolverResult._();

  const factory SolverResult({
    /// Bulunan en yakın sayı.
    required int result,

    /// Hedefe olan mesafe: |target - result|.
    required int distance,

    /// Çözüme ulaşmak için gereken adımlar.
    required List<SolverStep> steps,

    /// Tam eşleşme bulundu mu (distance == 0)?
    required bool isExact,
  }) = _SolverResult;

  /// Çözümün puan alıp alamayacağını kontrol eder (mesafe <= 9).
  bool get isValidForScoring => distance <= 9;
}

/// Solver tarafından üretilen tek bir işlem adımı.
/// GameStep'ten farklı olarak previousAvailableNumbers içermez.
@freezed
abstract class SolverStep with _$SolverStep {
  const SolverStep._();

  const factory SolverStep({
    required int firstNumber,
    required int secondNumber,
    required String operation,
    required int result,
  }) = _SolverStep;

  /// İşlemi okunabilir formatta döndürür: "25 * 4 = 100"
  String get displayString => '$firstNumber $operation $secondNumber = $result';
}
