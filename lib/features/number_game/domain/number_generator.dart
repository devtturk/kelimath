import 'dart:math';

import 'solver/solver.dart';

/// Sayı oyunu için rastgele sayı ve hedef üreteci.
///
/// gamemechanics.md kuralları:
/// - Küçükler (1-9): Her sayıdan max 2 adet
/// - Büyükler (10, 25, 40, 50, 60, 75): Tam olarak 1 tane
/// - Hedef: 100-999 arası, asal olmayan
/// - Garanti: Hedef sayıya ±9 mesafe içinde ulaşılabilir olmalı
class NumberGenerator {
  NumberGenerator({Random? random, NumberSolver? solver})
      : _random = random ?? Random(),
        _solver = solver ?? BacktrackingSolver();

  final Random _random;
  final NumberSolver _solver;

  /// Maksimum geçerli mesafe (puan alabilmek için).
  static const int maxValidDistance = 9;

  /// Maksimum yeniden deneme sayısı.
  static const int maxRetries = 10;

  /// Küçük sayılar havuzu (1-9).
  static const List<int> smallNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  /// Büyük sayılar havuzu.
  static const List<int> largeNumbers = [10, 25, 40, 50, 60, 75];

  /// Hedef sayı aralığı.
  static const int minTarget = 100;
  static const int maxTarget = 999;

  /// Oyun için 6 rastgele sayı üretir.
  ///
  /// Kurallar:
  /// - Büyük sayılardan tam olarak 1 tane (ulaşılabilirlik için zorunlu)
  /// - Küçük sayılardan her birinden en fazla 2 tane
  List<int> generateNumbers() {
    final result = <int>[];
    final smallCounts = <int, int>{};

    // Her zaman 1 büyük sayı ekle (ulaşılabilirlik için kritik)
    final largeIndex = _random.nextInt(largeNumbers.length);
    result.add(largeNumbers[largeIndex]);

    // Kalan 5 sayıyı küçüklerden doldur
    while (result.length < 6) {
      final smallIndex = _random.nextInt(smallNumbers.length);
      final number = smallNumbers[smallIndex];

      // Her küçük sayıdan max 2 tane
      final currentCount = smallCounts[number] ?? 0;
      if (currentCount < 2) {
        result.add(number);
        smallCounts[number] = currentCount + 1;
      }
    }

    // Listeyi karıştır
    result.shuffle(_random);

    return result;
  }

  /// 100-999 arası asal olmayan bir hedef sayı üretir.
  int generateTarget() {
    int target;

    do {
      target = minTarget + _random.nextInt(maxTarget - minTarget + 1);
    } while (_isPrime(target));

    return target;
  }

  /// Sayının asal olup olmadığını kontrol eder.
  bool _isPrime(int n) {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    final sqrt = _sqrt(n);
    for (int i = 3; i <= sqrt; i += 2) {
      if (n % i == 0) return false;
    }

    return true;
  }

  /// Tam sayı karekök hesaplar.
  int _sqrt(int n) {
    if (n < 0) return 0;
    if (n < 2) return n;

    int x = n;
    int y = (x + 1) ~/ 2;

    while (y < x) {
      x = y;
      y = (x + n ~/ x) ~/ 2;
    }

    return x;
  }

  /// Tam bir oyun seti üretir (6 sayı + hedef).
  ///
  /// NOT: Bu metot ulaşılabilirlik garantisi VERMEZ.
  /// Garanti için [generateValidatedGameSet] kullanın.
  ({List<int> numbers, int target}) generateGameSet() {
    return (
      numbers: generateNumbers(),
      target: generateTarget(),
    );
  }

  /// Ulaşılabilirlik garantili oyun seti üretir.
  ///
  /// Hedef sayıya ±[maxValidDistance] mesafe içinde ulaşılabilir
  /// olana kadar yeni setler üretir.
  ///
  /// [maxRetries] deneme sonunda hala geçerli set bulunamazsa,
  /// son üretilen seti döndürür (çok nadir durum).
  ///
  /// Döndürülen kayıt:
  /// - [numbers]: 6 sayı listesi
  /// - [target]: Hedef sayı
  /// - [solution]: Solver'ın bulduğu en iyi çözüm
  ({
    List<int> numbers,
    int target,
    SolverResult solution,
  }) generateValidatedGameSet() {
    for (int attempt = 0; attempt < maxRetries; attempt++) {
      final numbers = generateNumbers();
      final target = generateTarget();
      final solution = _solver.solve(numbers, target);

      // Geçerli bir çözüm bulunduysa döndür
      if (solution.distance <= maxValidDistance) {
        return (
          numbers: numbers,
          target: target,
          solution: solution,
        );
      }
    }

    // Fallback: Son denemeyi döndür (çok nadir)
    final numbers = generateNumbers();
    final target = generateTarget();
    final solution = _solver.solve(numbers, target);

    return (
      numbers: numbers,
      target: target,
      solution: solution,
    );
  }

  /// Sayılar için ulaşılabilir bir hedef seçer.
  ///
  /// Verilen sayılarla ulaşılabilecek sayılar arasından
  /// rastgele bir hedef seçer.
  ///
  /// Bu metot her zaman geçerli bir hedef döndürür.
  ({
    List<int> numbers,
    int target,
    SolverResult solution,
  }) generateWithReachableTarget() {
    final numbers = generateNumbers();

    // Tüm olası hedefleri dene ve ulaşılabilir olanları bul
    final reachableTargets = <int>[];

    for (int candidate = minTarget; candidate <= maxTarget; candidate++) {
      if (_isPrime(candidate)) continue;

      final solution = _solver.solve(numbers, candidate);
      if (solution.distance <= maxValidDistance) {
        reachableTargets.add(candidate);
      }
    }

    // Rastgele bir hedef seç
    if (reachableTargets.isNotEmpty) {
      final target = reachableTargets[_random.nextInt(reachableTargets.length)];
      final solution = _solver.solve(numbers, target);
      return (numbers: numbers, target: target, solution: solution);
    }

    // Fallback: Normal üretim (teoride buraya düşmemeli)
    final target = generateTarget();
    final solution = _solver.solve(numbers, target);
    return (numbers: numbers, target: target, solution: solution);
  }
}
