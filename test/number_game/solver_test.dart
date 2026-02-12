import 'dart:math';

import 'package:test/test.dart';
import 'package:kelimath/features/number_game/domain/solver/backtracking_solver.dart';
import 'package:kelimath/features/number_game/domain/number_generator.dart';

void main() {
  late BacktrackingSolver solver;

  setUp(() {
    solver = BacktrackingSolver();
  });

  group('BacktrackingSolver', () {
    group('basit senaryolar', () {
      test('hedef zaten mevcut sayılardan biriyse işlem gerekmez', () {
        final result = solver.solve([25, 50, 75, 100], 100);

        expect(result.isExact, isTrue);
        expect(result.distance, 0);
        expect(result.steps, isEmpty);
        expect(result.result, 100);
      });

      test('tek adımda çarpma: [25, 4] → 100', () {
        final result = solver.solve([25, 4], 100);

        expect(result.isExact, isTrue);
        expect(result.distance, 0);
        expect(result.result, 100);
        expect(result.steps.length, 1);
        expect(result.steps.first.displayString, '25 * 4 = 100');
      });

      test('tek adımda toplama: [60, 40] → 100', () {
        final result = solver.solve([60, 40], 100);

        expect(result.isExact, isTrue);
        expect(result.result, 100);
        expect(result.steps.length, 1);
      });

      test('tek adımda çıkarma: [150, 50] → 100', () {
        final result = solver.solve([150, 50], 100);

        expect(result.isExact, isTrue);
        expect(result.result, 100);
        expect(result.steps.length, 1);
      });

      test('tek adımda bölme: [200, 2] → 100', () {
        final result = solver.solve([200, 2], 100);

        expect(result.isExact, isTrue);
        expect(result.result, 100);
        expect(result.steps.length, 1);
      });
    });

    group('çok adımlı senaryolar', () {
      test('iki adımlı çözüm: [10, 5, 2] → 100', () {
        // 10 * 5 = 50, 50 * 2 = 100
        final result = solver.solve([10, 5, 2], 100);

        expect(result.isExact, isTrue);
        expect(result.result, 100);
        expect(result.steps.length, 2);
      });

      test('üç adımlı çözüm: [2, 3, 4, 5] → 100', () {
        // Örnek: 4*5=20, 20*3=60, 60+2=62 (exact değil)
        // veya 5*4=20, 20*3=60, 60+... gibi kombinasyonlar
        final result = solver.solve([2, 3, 4, 5], 100);

        // Exact match olmayabilir ama yakın olmalı
        expect(result.distance, lessThanOrEqualTo(10));
      });

      test('6 sayılı standart oyun senaryosu: [75, 3, 5, 8, 2, 9] → 425', () {
        final result = solver.solve([75, 3, 5, 8, 2, 9], 425);

        expect(result.distance, lessThanOrEqualTo(10),
            reason: 'Hedefe 10 içinde ulaşılmalı');
      });
    });

    group('en kısa yolu bulma', () {
      test('tek adım yeterli olduğunda tek adım döner', () {
        // 25 * 4 = 100 (tek adım yeterli)
        final result = solver.solve([25, 4], 100);

        expect(result.isExact, isTrue);
        expect(result.steps.length, 1,
            reason: 'Tek adım yeterli olduğunda daha fazla adım olmamalı');
      });

      test('iki farklı yol varsa birini seçer', () {
        // [50, 2, 25, 4] → 100
        // Yol 1: 50 * 2 = 100 (1 adım)
        // Yol 2: 25 * 4 = 100 (1 adım)
        // Yol 3: 50 + 25 + ... daha uzun
        final result = solver.solve([50, 2, 25, 4], 100);

        expect(result.isExact, isTrue);
        // Exact match bulunmalı, adım sayısı optimize edilmiş olmalı
        expect(result.steps.length, lessThanOrEqualTo(2));
      });
    });

    group('ulaşılamaz senaryolar', () {
      test('exact match yoksa en yakın sonucu döner', () {
        // Küçük sayılarla büyük hedefe ulaşmak zor
        final result = solver.solve([1, 2, 3], 500);

        expect(result.isExact, isFalse);
        expect(result.result, greaterThan(0));
        // En azından bir çözüm bulunmalı
        expect(result.distance, lessThan(500));
      });

      test('sadece 1lerle 999a ulaşılamaz', () {
        final result = solver.solve([1, 1, 1, 1, 1, 1], 999);

        expect(result.isExact, isFalse);
        // Çarpma ile: (1+1)*(1+1)=4, 4*(1+1)=8, 8+1=9 gibi
        // Maksimum ulaşılabilir değer ~720 civarında (6! = 6*5*4*3*2*1)
        // Ama 6 tane 1 ile en fazla birkaç düzine
        expect(result.result, lessThan(100),
            reason: 'Sadece 1lerle 100den büyük sayıya ulaşılmamalı');
      });
    });

    group('özel durumlar', () {
      test('bölme kalanlı olduğunda geçersiz', () {
        // 10 / 3 kalanlı, yapılmamalı
        final result = solver.solve([10, 3], 3);

        // 10 - 3 = 7 veya 3 * 3 = 9 (ama 3 yok ikinci kez)
        // En yakın: 3 (zaten mevcut) veya 10 - 3 = 7
        expect(result.result, isIn([3, 7, 10, 13, 30]));
      });

      test('negatif sonuç üretmez', () {
        final result = solver.solve([3, 10], 50);

        // Tüm adımlar pozitif sonuç vermeli
        for (final step in result.steps) {
          expect(step.result, greaterThan(0));
        }
      });

      test('sıfır sonuç üretmez', () {
        final result = solver.solve([5, 5, 10], 100);

        // 5 - 5 = 0 yapılmamalı
        for (final step in result.steps) {
          expect(step.result, greaterThan(0));
        }
      });
    });

    group('SolverResult özellikleri', () {
      test('isValidForScoring mesafe <= 9 için true', () {
        final result = solver.solve([25, 4], 100);
        expect(result.isValidForScoring, isTrue);
      });

      test('isValidForScoring mesafe >= 10 için false', () {
        final result = solver.solve([1, 1, 1, 1, 1, 1], 999);
        expect(result.isValidForScoring, isFalse);
      });

      test('displayString doğru format döner', () {
        final result = solver.solve([25, 4], 100);

        if (result.steps.isNotEmpty) {
          final step = result.steps.first;
          expect(step.displayString, contains('='));
          expect(step.displayString, contains('100'));
        }
      });
    });

    group('performans testleri', () {
      test('100 rastgele oyunda hızlı çözüm bulur', () {
        final stopwatch = Stopwatch()..start();

        for (int seed = 0; seed < 100; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final gameSet = gen.generateGameSet();

          final result = solver.solve(gameSet.numbers, gameSet.target);

          // Her oyunda bir sonuç bulunmalı
          expect(result.result, greaterThan(0));
        }

        stopwatch.stop();
        print('\n100 oyun çözüm süresi: ${stopwatch.elapsedMilliseconds}ms');

        // 100 oyun 5 saniyeden kısa sürmeli
        expect(stopwatch.elapsedMilliseconds, lessThan(5000),
            reason: 'Performans yetersiz: ${stopwatch.elapsedMilliseconds}ms');
      });

      test('1000 rastgele oyunda ulaşılabilirlik kontrolü', () {
        int exactCount = 0;
        int validCount = 0; // mesafe <= 9

        for (int seed = 0; seed < 1000; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final gameSet = gen.generateGameSet();

          final result = solver.solve(gameSet.numbers, gameSet.target);

          if (result.isExact) exactCount++;
          if (result.isValidForScoring) validCount++;
        }

        print('\n=== 1000 OYUN SOLVER ANALİZİ ===');
        print('Exact match: $exactCount (${exactCount / 10}%)');
        print('Valid (≤9): $validCount (${validCount / 10}%)');

        // En az %90 oyunda geçerli sonuç bulunmalı
        expect(validCount, greaterThan(900),
            reason: 'Geçerli çözüm oranı düşük: ${validCount / 10}%');
      });
    });
  });
}
