import 'package:test/test.dart';
import 'package:kelimath/features/word_game/domain/letter_validation.dart';

void main() {
  group('LetterValidation', () {
    group('validate', () {
      test('geçerli kelime kabul edilir', () {
        final result = LetterValidation.validate(
          guess: 'KALEM',
          availableLetters: ['K', 'A', 'L', 'E', 'M', 'B', 'C', 'D'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
        expect(result.word, 'KALEM');
        expect(result.invalidLetterIndices, isEmpty);
        expect(result.jokerUsed, isFalse);
      });

      test('küçük harfle yazılan kelime kabul edilir', () {
        final result = LetterValidation.validate(
          guess: 'kalem',
          availableLetters: ['K', 'A', 'L', 'E', 'M', 'B', 'C', 'D'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
        expect(result.word, 'KALEM');
      });

      test('olmayan harf ile geçersiz', () {
        final result = LetterValidation.validate(
          guess: 'KALEM',
          availableLetters: ['K', 'A', 'L', 'B', 'C', 'D', 'F', 'G'],
          jokerAvailable: false, // Joker yok
        );

        expect(result.isValid, isFalse);
        expect(result.errorMessage, contains('E'));
        expect(result.invalidLetterIndices, contains(3)); // E pozisyonu
      });

      test('joker eksik harfi tamamlar', () {
        final result = LetterValidation.validate(
          guess: 'KALEM',
          availableLetters: ['K', 'A', 'L', 'B', 'C', 'D', 'F', 'G'],
          jokerAvailable: true,
        );

        expect(result.isValid, isFalse); // E ve M yok, joker sadece 1 tane
        expect(result.jokerUsed, isTrue);
        expect(result.jokerLetter, 'E');
      });

      test('joker tek eksik harfi tamamlar', () {
        final result = LetterValidation.validate(
          guess: 'KALEM',
          availableLetters: ['K', 'A', 'L', 'E', 'B', 'C', 'D', 'F'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
        expect(result.jokerUsed, isTrue);
        expect(result.jokerLetter, 'M');
      });

      test('aynı harf 2 kez kullanılamaz (havuzda 1 tane varsa)', () {
        final result = LetterValidation.validate(
          guess: 'KARAR', // 2 tane R ve 2 tane A lazım
          availableLetters: ['K', 'A', 'R', 'B', 'C', 'D', 'E', 'F'],
          jokerAvailable: false,
        );

        expect(result.isValid, isFalse);
        // İkinci A ve ikinci R eksik
        expect(result.invalidLetterIndices.length, greaterThan(0));
      });

      test('aynı harf havuzda 2 kez varsa 2 kez kullanılabilir', () {
        final result = LetterValidation.validate(
          guess: 'AA', // 2 tane A lazım
          availableLetters: ['A', 'A', 'B', 'C', 'D', 'E', 'F', 'G'],
          jokerAvailable: false,
        );

        // AA geçerli değil (min 3 harf) ama harf kontrolü geçmeli
        expect(result.invalidLetterIndices, isEmpty);
      });

      test('boş kelime geçerli (henüz yazılmamış)', () {
        final result = LetterValidation.validate(
          guess: '',
          availableLetters: ['K', 'A', 'L', 'E', 'M', 'B', 'C', 'D'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
        expect(result.word, '');
      });

      test('birden fazla geçersiz harf', () {
        final result = LetterValidation.validate(
          guess: 'XYZ',
          availableLetters: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
          jokerAvailable: true,
        );

        expect(result.isValid, isFalse);
        // X için joker kullanılır, Y ve Z geçersiz
        expect(result.invalidLetterIndices.length, 2);
      });
    });

    group('calculateLetterUsage', () {
      test('kullanılan harfler işaretlenir', () {
        final usage = LetterValidation.calculateLetterUsage(
          guess: 'KAL',
          availableLetters: ['K', 'A', 'L', 'E', 'M', 'B', 'C', 'D'],
        );

        expect(usage.length, 8);

        // K, A, L kullanılmış olmalı
        final kUsage = usage.firstWhere((u) => u.letter == 'K');
        final aUsage = usage.firstWhere((u) => u.letter == 'A');
        final lUsage = usage.firstWhere((u) => u.letter == 'L');
        final eUsage = usage.firstWhere((u) => u.letter == 'E');

        expect(kUsage.isUsed, isTrue);
        expect(kUsage.positionInGuess, 0);

        expect(aUsage.isUsed, isTrue);
        expect(aUsage.positionInGuess, 1);

        expect(lUsage.isUsed, isTrue);
        expect(lUsage.positionInGuess, 2);

        expect(eUsage.isUsed, isFalse);
        expect(eUsage.positionInGuess, isNull);
      });

      test('aynı harften birden fazla varsa ayrı ayrı eşleşir', () {
        final usage = LetterValidation.calculateLetterUsage(
          guess: 'AA',
          availableLetters: ['A', 'A', 'B', 'C', 'D', 'E', 'F', 'G'],
        );

        final aUsages = usage.where((u) => u.letter == 'A').toList();
        expect(aUsages.length, 2);
        expect(aUsages[0].isUsed, isTrue);
        expect(aUsages[0].positionInGuess, 0);
        expect(aUsages[1].isUsed, isTrue);
        expect(aUsages[1].positionInGuess, 1);
      });

      test('boş kelime için hiçbir harf kullanılmış değil', () {
        final usage = LetterValidation.calculateLetterUsage(
          guess: '',
          availableLetters: ['K', 'A', 'L', 'E', 'M', 'B', 'C', 'D'],
        );

        expect(usage.every((u) => !u.isUsed), isTrue);
      });
    });

    group('getRequiredLetters', () {
      test('gerekli harfleri listeler', () {
        final result = LetterValidation.getRequiredLetters(
          word: 'KALEM',
          availableLetters: ['K', 'A', 'L', 'E', 'M', 'B', 'C', 'D'],
          jokerAvailable: true,
        );

        expect(result.requiredLetters, ['K', 'A', 'L', 'E', 'M']);
        expect(result.jokerFor, isNull);
      });

      test('joker gereken harf için * koyar', () {
        final result = LetterValidation.getRequiredLetters(
          word: 'KALEM',
          availableLetters: ['K', 'A', 'L', 'E', 'B', 'C', 'D', 'F'],
          jokerAvailable: true,
        );

        expect(result.requiredLetters, ['K', 'A', 'L', 'E', '*']);
        expect(result.jokerFor, 'M');
      });
    });

    group('maxPossibleLength', () {
      test('joker olmadan 8 harf', () {
        final max = LetterValidation.maxPossibleLength(
          ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
          false,
        );
        expect(max, 8);
      });

      test('joker ile 9 harf', () {
        final max = LetterValidation.maxPossibleLength(
          ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
          true,
        );
        expect(max, 9);
      });
    });
  });
}
