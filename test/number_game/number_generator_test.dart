import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kelimath/features/number_game/domain/number_generator.dart';

void main() {
  group('NumberGenerator', () {
    late NumberGenerator generator;

    setUp(() {
      // Sabit seed ile test edilebilir sonuçlar
      generator = NumberGenerator(random: Random(42));
    });

    group('generateNumbers', () {
      test('6 sayı üretir', () {
        final numbers = generator.generateNumbers();
        expect(numbers.length, 6);
      });

      test('tam olarak 1 büyük sayı içerir', () {
        // Birden fazla test için farklı seed'ler dene
        for (int seed = 0; seed < 100; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final numbers = gen.generateNumbers();

          final largeCount = numbers
              .where((n) => NumberGenerator.largeNumbers.contains(n))
              .length;

          expect(largeCount, equals(1),
              reason: 'Seed $seed ile $largeCount büyük sayı üretildi (1 olmalı)');
        }
      });

      test('küçük sayılardan her biri en fazla 2 kez bulunur', () {
        for (int seed = 0; seed < 100; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final numbers = gen.generateNumbers();

          for (final small in NumberGenerator.smallNumbers) {
            final count = numbers.where((n) => n == small).length;
            expect(count, lessThanOrEqualTo(2),
                reason: 'Seed $seed ile $small sayısı $count kez bulundu');
          }
        }
      });

      test('tüm sayılar pozitif', () {
        final numbers = generator.generateNumbers();
        expect(numbers.every((n) => n > 0), isTrue);
      });
    });

    group('generateTarget', () {
      test('100-999 arasında bir sayı üretir', () {
        for (int seed = 0; seed < 100; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final target = gen.generateTarget();

          expect(target, greaterThanOrEqualTo(100));
          expect(target, lessThanOrEqualTo(999));
        }
      });

      test('asal sayı üretmez', () {
        for (int seed = 0; seed < 100; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final target = gen.generateTarget();

          expect(_isPrime(target), isFalse,
              reason: 'Seed $seed ile asal sayı $target üretildi');
        }
      });
    });

    group('generateGameSet', () {
      test('6 sayı ve bir hedef döner', () {
        final gameSet = generator.generateGameSet();

        expect(gameSet.numbers.length, 6);
        expect(gameSet.target, greaterThanOrEqualTo(100));
        expect(gameSet.target, lessThanOrEqualTo(999));
      });
    });

    group('generateValidatedGameSet', () {
      test('ulaşılabilir oyun seti üretir', () {
        final gameSet = generator.generateValidatedGameSet();

        expect(gameSet.numbers.length, 6);
        expect(gameSet.target, greaterThanOrEqualTo(100));
        expect(gameSet.target, lessThanOrEqualTo(999));
        expect(gameSet.solution.distance, lessThanOrEqualTo(9),
            reason: 'Çözüm mesafesi 9\'dan fazla olamaz');
      });

      test('100 oyunda hepsi ulaşılabilir', () {
        int validCount = 0;

        for (int seed = 0; seed < 100; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final gameSet = gen.generateValidatedGameSet();

          if (gameSet.solution.distance <= 9) {
            validCount++;
          }
        }

        expect(validCount, 100,
            reason: 'Tüm oyunlar ulaşılabilir olmalı');
      });

      test('çözüm bilgisi içerir', () {
        final gameSet = generator.generateValidatedGameSet();

        expect(gameSet.solution, isNotNull);
        expect(gameSet.solution.result, greaterThan(0));
      });
    });

    group('generateWithReachableTarget', () {
      test('her zaman geçerli hedef üretir', () {
        for (int seed = 0; seed < 10; seed++) {
          final gen = NumberGenerator(random: Random(seed));
          final gameSet = gen.generateWithReachableTarget();

          expect(gameSet.solution.distance, lessThanOrEqualTo(9),
              reason: 'Seed $seed için geçersiz hedef');
        }
      });
    });
  });
}

/// Test için asal sayı kontrolü.
bool _isPrime(int n) {
  if (n < 2) return false;
  if (n == 2) return true;
  if (n % 2 == 0) return false;

  for (int i = 3; i * i <= n; i += 2) {
    if (n % i == 0) return false;
  }
  return true;
}
