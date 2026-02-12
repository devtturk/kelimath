import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kelimath/features/number_game/domain/number_generator.dart';
import 'package:kelimath/features/number_game/domain/operation.dart';

/// Verilen sayılarla hedefe ne kadar yaklaşılabileceğini hesaplayan brute-force solver.
class ReachabilitySolver {
  /// Verilen sayılarla ulaşılabilecek en yakın mesafeyi bulur.
  static int findClosestDistance(List<int> numbers, int target) {
    final allReachable = _getAllReachableNumbers(numbers);

    int minDistance = target; // En kötü durum: hiç işlem yapmadan

    // Başlangıç sayılarını da kontrol et
    for (final n in numbers) {
      final distance = (n - target).abs();
      if (distance < minDistance) {
        minDistance = distance;
      }
    }

    // Tüm ulaşılabilir sayıları kontrol et
    for (final n in allReachable) {
      final distance = (n - target).abs();
      if (distance < minDistance) {
        minDistance = distance;
      }
      if (minDistance == 0) break; // Tam eşleşme bulundu
    }

    return minDistance;
  }

  /// Verilen sayılarla ulaşılabilecek tüm sayıları bulur (brute-force).
  static Set<int> _getAllReachableNumbers(List<int> numbers) {
    final reachable = <int>{};
    _findAllCombinations(numbers, reachable);
    return reachable;
  }

  static void _findAllCombinations(List<int> available, Set<int> reachable) {
    // Mevcut sayıları ekle
    for (final n in available) {
      if (n > 0) reachable.add(n);
    }

    // 2'den az sayı varsa işlem yapılamaz
    if (available.length < 2) return;

    // Tüm çiftleri ve işlemleri dene
    for (int i = 0; i < available.length; i++) {
      for (int j = 0; j < available.length; j++) {
        if (i == j) continue;

        final a = available[i];
        final b = available[j];

        for (final op in Operation.values) {
          // Geçerlilik kontrolü
          if (op == Operation.divide) {
            if (b == 0 || a % b != 0) continue;
          }

          final result = op.apply(a, b);

          // Sonuç pozitif olmalı
          if (result <= 0) continue;

          // Yeni liste oluştur (kullanılan sayıları çıkar, sonucu ekle)
          final newList = <int>[];
          for (int k = 0; k < available.length; k++) {
            if (k != i && k != j) {
              newList.add(available[k]);
            }
          }
          newList.add(result);

          // Rekürsif olarak devam et
          _findAllCombinations(newList, reachable);
        }
      }
    }
  }
}

void main() {
  group('Reachability Analysis', () {
    test('belirli zor senaryoları analiz et', () {
      // Bilinen zor senaryolar
      final testCases = <({List<int> numbers, int target, String desc})>[
        (numbers: [1, 1, 1, 1, 1, 1], target: 999, desc: 'En küçük sayılarla en büyük hedef'),
        (numbers: [1, 2, 3, 4, 5, 6], target: 997, desc: 'Küçük sayılarla büyük hedef'),
        (numbers: [9, 9, 8, 8, 7, 7], target: 100, desc: 'Büyük küçüklerle küçük hedef'),
        (numbers: [1, 1, 2, 2, 3, 3], target: 500, desc: 'Tekrarlı küçük sayılarla orta hedef'),
      ];

      print('\n=== ZOR SENARYO ANALİZİ ===\n');

      for (final testCase in testCases) {
        final numbers = testCase.numbers;
        final target = testCase.target;
        final desc = testCase.desc;

        final minDistance = ReachabilitySolver.findClosestDistance(numbers, target);
        final reachable = minDistance <= 10;

        print('$desc');
        print('  Sayılar: $numbers');
        print('  Hedef: $target');
        print('  En yakın mesafe: $minDistance');
        print('  10 içinde ulaşılabilir: ${reachable ? "EVET" : "HAYIR ❌"}');
        print('');

        // Bu test sadece bilgi amaçlı, fail etmez
      }
    });

    test('1000 rastgele oyun setinde ulaşılamazlık oranını hesapla', () {
      int totalGames = 1000;
      int unreachableCount = 0;
      final unreachableExamples = <Map<String, dynamic>>[];

      for (int seed = 0; seed < totalGames; seed++) {
        final generator = NumberGenerator(random: Random(seed));
        final gameSet = generator.generateGameSet();

        final minDistance = ReachabilitySolver.findClosestDistance(
          gameSet.numbers,
          gameSet.target,
        );

        if (minDistance > 10) {
          unreachableCount++;
          if (unreachableExamples.length < 10) {
            unreachableExamples.add({
              'seed': seed,
              'numbers': gameSet.numbers,
              'target': gameSet.target,
              'minDistance': minDistance,
            });
          }
        }
      }

      final unreachablePercent = (unreachableCount / totalGames * 100).toStringAsFixed(2);

      print('\n=== RASTGELE OYUN ANALİZİ ===\n');
      print('Toplam oyun: $totalGames');
      print('Ulaşılamaz oyun: $unreachableCount ($unreachablePercent%)');
      print('');

      if (unreachableExamples.isNotEmpty) {
        print('Ulaşılamaz örnekler:');
        for (final example in unreachableExamples) {
          print('  Seed ${example['seed']}: ${example['numbers']} -> ${example['target']} (mesafe: ${example['minDistance']})');
        }
      }

      // Bu değer çok yüksekse generator'ı iyileştirmemiz gerekir
      expect(
        unreachableCount,
        lessThan(totalGames * 0.3), // %30'dan fazla olmamalı
        reason: 'Ulaşılamaz oyun oranı çok yüksek: $unreachablePercent%',
      );
    });

    test('büyük sayı içeren setlerin ulaşılabilirlik oranı', () {
      int totalWithLarge = 0;
      int unreachableWithLarge = 0;
      int totalWithoutLarge = 0;
      int unreachableWithoutLarge = 0;

      for (int seed = 0; seed < 500; seed++) {
        final generator = NumberGenerator(random: Random(seed));
        final gameSet = generator.generateGameSet();

        final hasLarge = gameSet.numbers.any(
          (n) => NumberGenerator.largeNumbers.contains(n),
        );

        final minDistance = ReachabilitySolver.findClosestDistance(
          gameSet.numbers,
          gameSet.target,
        );

        if (hasLarge) {
          totalWithLarge++;
          if (minDistance > 10) unreachableWithLarge++;
        } else {
          totalWithoutLarge++;
          if (minDistance > 10) unreachableWithoutLarge++;
        }
      }

      print('\n=== BÜYÜK SAYI ANALİZİ ===\n');
      print('Büyük sayı İÇEREN setler:');
      print('  Toplam: $totalWithLarge');
      print('  Ulaşılamaz: $unreachableWithLarge (${(unreachableWithLarge/totalWithLarge*100).toStringAsFixed(1)}%)');
      print('');
      print('Büyük sayı İÇERMEYEN setler:');
      print('  Toplam: $totalWithoutLarge');
      print('  Ulaşılamaz: $unreachableWithoutLarge (${totalWithoutLarge > 0 ? (unreachableWithoutLarge/totalWithoutLarge*100).toStringAsFixed(1) : 0}%)');
    });
  });
}
