import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kelimath/features/number_game/domain/number_generator.dart';
import 'package:kelimath/features/number_game/domain/operation.dart';

/// Basit brute-force solver.
class SimpleSolver {
  static int findClosestDistance(List<int> numbers, int target) {
    final allReachable = <int>{};
    _findAll(numbers, allReachable, 0);

    int minDistance = target;
    for (final n in numbers) {
      final d = (n - target).abs();
      if (d < minDistance) minDistance = d;
    }
    for (final n in allReachable) {
      final d = (n - target).abs();
      if (d < minDistance) minDistance = d;
      if (minDistance == 0) break;
    }
    return minDistance;
  }

  static void _findAll(List<int> available, Set<int> reachable, int depth) {
    if (depth > 5 || available.length < 2) return;

    for (int i = 0; i < available.length; i++) {
      for (int j = 0; j < available.length; j++) {
        if (i == j) continue;
        final a = available[i], b = available[j];

        for (final op in Operation.values) {
          if (op == Operation.divide && (b == 0 || a % b != 0)) continue;
          final result = op.apply(a, b);
          if (result <= 0) continue;

          reachable.add(result);

          final newList = <int>[result];
          for (int k = 0; k < available.length; k++) {
            if (k != i && k != j) newList.add(available[k]);
          }
          _findAll(newList, reachable, depth + 1);
        }
      }
    }
  }
}

void main() {
  test('100 oyunda ulaşılabilirlik kontrolü', () {
    int unreachable = 0;

    for (int seed = 0; seed < 100; seed++) {
      final gen = NumberGenerator(random: Random(seed));
      final gameSet = gen.generateGameSet();
      final dist = SimpleSolver.findClosestDistance(gameSet.numbers, gameSet.target);
      if (dist > 10) unreachable++;
    }

    print('\\n100 oyunda ulaşılamaz: $unreachable (${unreachable}%)');
    expect(unreachable, lessThan(5), reason: 'Ulaşılamaz oran çok yüksek');
  });
}
