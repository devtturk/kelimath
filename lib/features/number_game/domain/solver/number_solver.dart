import 'solver_result.dart';

/// Sayı oyunu için çözüm bulan solver interface'i.
///
/// Verilen sayılarla hedefe ulaşan en kısa yolu bulur.
/// Exact match yoksa en yakın sonucu döndürür.
abstract class NumberSolver {
  /// Verilen [numbers] ile [target] sayısına en yakın sonucu bulur.
  ///
  /// Döndürülen [SolverResult]:
  /// - En yakın sayıyı ([result])
  /// - Hedefe mesafeyi ([distance])
  /// - Çözüm adımlarını ([steps])
  /// - Tam eşleşme olup olmadığını ([isExact])
  ///
  /// Eğer hedef sayı mevcut sayılardan biriyse, boş adım listesiyle
  /// döndürür (işlem gerekmez).
  SolverResult solve(List<int> numbers, int target);
}
