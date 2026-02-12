import '../operation.dart';
import 'number_solver.dart';
import 'solver_result.dart';

/// Backtracking algoritması ile çözüm bulan solver.
///
/// Optimizasyonlar:
/// 1. Early exit: Exact match bulununca durdur
/// 2. Step count priority: Aynı distance'ta daha az adımlı çözümü tercih et
/// 3. Commutative skip: a+b = b+a için tekrar deneme
/// 4. Result bound: Çok büyük/küçük sonuçları atla
class BacktrackingSolver implements NumberSolver {
  // En iyi çözümü takip eden değişkenler
  int _bestResult = 0;
  int _bestDistance = 999999;
  List<SolverStep> _bestSteps = [];
  int _target = 0;

  // Arama erken durmalı mı?
  bool _foundExact = false;

  @override
  SolverResult solve(List<int> numbers, int target) {
    // State'i sıfırla
    _target = target;
    _bestResult = 0;
    _bestDistance = 999999;
    _bestSteps = [];
    _foundExact = false;

    // İlk olarak mevcut sayıları kontrol et (işlem gerekmeyebilir)
    for (final num in numbers) {
      _checkAndUpdateBest(num, []);
      if (_foundExact) break;
    }

    // Eğer exact match yoksa backtracking ile ara
    if (!_foundExact) {
      _backtrack(List<int>.from(numbers), []);
    }

    return SolverResult(
      result: _bestResult,
      distance: _bestDistance,
      steps: _bestSteps,
      isExact: _bestDistance == 0,
    );
  }

  /// Mevcut sayıyı kontrol et ve gerekirse en iyi sonucu güncelle.
  void _checkAndUpdateBest(int value, List<SolverStep> steps) {
    final distance = (value - _target).abs();

    // Daha iyi mi? (daha yakın VEYA aynı yakınlıkta daha az adım)
    if (distance < _bestDistance ||
        (distance == _bestDistance && steps.length < _bestSteps.length)) {
      _bestResult = value;
      _bestDistance = distance;
      _bestSteps = List<SolverStep>.from(steps);

      if (distance == 0) {
        _foundExact = true;
      }
    }
  }

  /// Backtracking ile tüm olası işlemleri dene.
  void _backtrack(List<int> available, List<SolverStep> steps) {
    // Exact match bulunduysa dur
    if (_foundExact) return;

    // En az 2 sayı lazım işlem için
    if (available.length < 2) return;

    // Tüm sayı çiftlerini dene
    for (int i = 0; i < available.length; i++) {
      for (int j = 0; j < available.length; j++) {
        if (i == j) continue;
        if (_foundExact) return;

        final a = available[i];
        final b = available[j];

        // Tüm işlemleri dene
        for (final op in Operation.values) {
          if (_foundExact) return;

          // Commutative optimizasyon: a+b ve b+a, a*b ve b*a aynı
          // i < j koşuluyla sadece birini dene
          if ((op == Operation.add || op == Operation.multiply) && i > j) {
            continue;
          }

          // Bölme geçerlilik kontrolü
          if (op == Operation.divide) {
            if (b == 0 || a % b != 0) continue;
          }

          final result = op.apply(a, b);

          // Sonuç pozitif olmalı
          if (result <= 0) continue;

          // Bound pruning: Çok büyük sonuçları atla
          if (result > _target * 10) continue;

          // Yeni adım oluştur
          final newStep = SolverStep(
            firstNumber: a,
            secondNumber: b,
            operation: op.symbol,
            result: result,
          );

          final newSteps = [...steps, newStep];

          // Sonucu kontrol et
          _checkAndUpdateBest(result, newSteps);

          if (_foundExact) return;

          // Yeni listeyi oluştur ve devam et
          final newAvailable = <int>[];
          for (int k = 0; k < available.length; k++) {
            if (k != i && k != j) {
              newAvailable.add(available[k]);
            }
          }
          newAvailable.add(result);

          // Rekürsif olarak devam et
          _backtrack(newAvailable, newSteps);
        }
      }
    }
  }
}
