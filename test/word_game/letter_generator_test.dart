import 'dart:math';

import 'package:test/test.dart';
import 'package:kelimath/features/word_game/domain/letter_generator.dart';

void main() {
  group('LetterGenerator', () {
    late LetterGenerator generator;

    setUp(() {
      generator = LetterGenerator(random: Random(42));
    });

    group('generateRandomLetters', () {
      test('8 harf üretir', () {
        final letters = generator.generateRandomLetters();
        expect(letters.length, 8);
      });

      test('3-4 sesli harf içerir', () {
        // Birden fazla seed ile test et
        for (int seed = 0; seed < 100; seed++) {
          final gen = LetterGenerator(random: Random(seed));
          final letters = gen.generateRandomLetters();

          final vowelCount = letters
              .where((l) => LetterGenerator.vowels.contains(l))
              .length;

          expect(
            vowelCount,
            inInclusiveRange(3, 4),
            reason: 'Seed $seed ile $vowelCount sesli harf üretildi',
          );
        }
      });

      test('tüm harfler geçerli Türkçe harfler', () {
        final letters = generator.generateRandomLetters();
        final allLetters = [
          ...LetterGenerator.vowels,
          ...LetterGenerator.consonants,
        ];

        for (final letter in letters) {
          expect(
            allLetters.contains(letter),
            isTrue,
            reason: '$letter geçerli bir Türkçe harf değil',
          );
        }
      });
    });

    group('drawVowel', () {
      test('sadece sesli harf döner', () {
        for (int i = 0; i < 100; i++) {
          final vowel = generator.drawVowel();
          expect(
            LetterGenerator.vowels.contains(vowel),
            isTrue,
            reason: '$vowel sesli değil',
          );
        }
      });
    });

    group('drawConsonant', () {
      test('sadece sessiz harf döner', () {
        for (int i = 0; i < 100; i++) {
          final consonant = generator.drawConsonant();
          expect(
            LetterGenerator.consonants.contains(consonant),
            isTrue,
            reason: '$consonant sessiz değil',
          );
        }
      });
    });

    group('addVowelTo', () {
      test('mevcut listeye sesli ekler', () {
        final current = ['B', 'C', 'D'];
        final vowel = generator.addVowelTo(current);

        expect(vowel, isNotNull);
        expect(LetterGenerator.vowels.contains(vowel), isTrue);
      });

      test('maksimum sesli sayısına ulaşınca null döner', () {
        // 4 sesli + 3 sessiz = 7 harf
        final current = ['A', 'E', 'İ', 'O', 'B', 'C', 'D'];
        final vowel = generator.addVowelTo(current);

        expect(vowel, isNull);
      });

      test('8 harfe ulaşınca null döner', () {
        final current = ['A', 'E', 'İ', 'B', 'C', 'D', 'K', 'L'];
        final vowel = generator.addVowelTo(current);

        expect(vowel, isNull);
      });
    });

    group('addConsonantTo', () {
      test('mevcut listeye sessiz ekler', () {
        final current = ['A', 'E', 'İ'];
        final consonant = generator.addConsonantTo(current);

        expect(consonant, isNotNull);
        expect(LetterGenerator.consonants.contains(consonant), isTrue);
      });

      test('minimum sesli sağlanamayacaksa null döner', () {
        // 1 sesli + 5 sessiz = 6 harf, kalan 2 slot
        // En az 2 sesli daha lazım (min 3)
        final current = ['A', 'B', 'C', 'D', 'K', 'L'];
        final consonant = generator.addConsonantTo(current);

        expect(consonant, isNull);
      });
    });

    group('completeLetters', () {
      test('boş listeden 8 harf tamamlar', () {
        final result = generator.completeLetters([]);
        expect(result.length, 8);
      });

      test('kısmi listeden 8 harfe tamamlar', () {
        final current = ['A', 'B', 'C'];
        final result = generator.completeLetters(current);

        expect(result.length, 8);
        expect(result.take(3).toList(), current);
      });

      test('sesli kuralına uyar', () {
        for (int seed = 0; seed < 50; seed++) {
          final gen = LetterGenerator(random: Random(seed));
          final partial = ['B', 'C']; // 2 sessiz ile başla
          final result = gen.completeLetters(partial);

          final vowelCount = result
              .where((l) => LetterGenerator.vowels.contains(l))
              .length;

          expect(
            vowelCount,
            inInclusiveRange(3, 4),
            reason: 'Seed $seed: tamamlanmış listede $vowelCount sesli',
          );
        }
      });

      test('tam listeyi değiştirmez', () {
        final full = ['A', 'E', 'İ', 'O', 'B', 'C', 'D', 'K'];
        final result = generator.completeLetters(full);

        expect(result, full);
      });
    });

    group('isVowel / isConsonant', () {
      test('sesli harfleri doğru tanır', () {
        for (final vowel in LetterGenerator.vowels) {
          expect(LetterGenerator.isVowel(vowel), isTrue);
          expect(LetterGenerator.isConsonant(vowel), isFalse);
        }
      });

      test('sessiz harfleri doğru tanır', () {
        for (final consonant in LetterGenerator.consonants) {
          expect(LetterGenerator.isConsonant(consonant), isTrue);
          expect(LetterGenerator.isVowel(consonant), isFalse);
        }
      });

      test('küçük harflerle de çalışır', () {
        expect(LetterGenerator.isVowel('a'), isTrue);
        expect(LetterGenerator.isConsonant('b'), isTrue);
      });
    });

    group('ağırlıklı dağılım', () {
      test('yüksek frekanslı harfler daha sık görülür', () {
        final counts = <String, int>{};

        // 10000 harf çek
        for (int i = 0; i < 10000; i++) {
          final gen = LetterGenerator(random: Random(i));
          final letter = gen.drawVowel();
          counts[letter] = (counts[letter] ?? 0) + 1;
        }

        // A ve E yüksek frekanslı, daha sık görülmeli
        // Ö ve Ü düşük frekanslı
        expect(counts['A']! > counts['Ö']!, isTrue,
            reason: 'A daha sık görülmeli');
        expect(counts['E']! > counts['Ü']!, isTrue,
            reason: 'E daha sık görülmeli');
      });
    });
  });
}
