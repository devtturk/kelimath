import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import 'package:kelimath/features/word_game/application/word_game_controller.dart';
import 'package:kelimath/features/word_game/domain/domain.dart';

void main() {
  group('WordGameController', () {
    late ProviderContainer container;
    late WordGameController controller;

    setUp(() {
      container = ProviderContainer();
      controller = container.read(wordGameControllerProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    group('build', () {
      test('başlangıç state\'i doğru', () {
        final state = container.read(wordGameControllerProvider);

        expect(state.availableLetters, isEmpty);
        expect(state.currentGuess, '');
        expect(state.jokerUsed, isFalse);
        expect(state.status, GameStatus.notStarted);
      });
    });

    group('startGame', () {
      test('belirtilen harflerle oyunu başlatır', () {
        final letters = ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'];
        controller.startGame(letters: letters);

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters, letters);
        expect(state.status, GameStatus.playing);
        expect(state.timeRemaining, 60);
        expect(state.lettersReady, isTrue);
      });

      test('harfler belirtilmezse rastgele üretir', () {
        controller.startGame();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters.length, 8);
        expect(state.status, GameStatus.playing);
        expect(state.lettersReady, isTrue);
      });
    });

    group('startRandomGame', () {
      test('rastgele harflerle oyunu başlatır', () {
        controller.startRandomGame();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters.length, 8);
        expect(state.status, GameStatus.playing);
      });
    });

    group('startManualGame', () {
      test('boş harflerle manuel oyunu başlatır', () {
        controller.startManualGame();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters, isEmpty);
        expect(state.status, GameStatus.playing);
        expect(state.lettersReady, isFalse);
      });
    });

    group('addVowel', () {
      test('sesli harf ekler', () {
        controller.startManualGame();
        controller.addVowel();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters.length, 1);
        expect(
          LetterGenerator.vowels.contains(state.availableLetters.first),
          isTrue,
        );
      });

      test('8 harften fazla eklemez', () {
        controller.startGame(letters: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']);
        controller.addVowel();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters.length, 8);
      });
    });

    group('addConsonant', () {
      test('sessiz harf ekler', () {
        controller.startManualGame();
        controller.addConsonant();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters.length, 1);
        expect(
          LetterGenerator.consonants.contains(state.availableLetters.first),
          isTrue,
        );
      });
    });

    group('completeLetters', () {
      test('kalan harfleri tamamlar', () {
        controller.startManualGame();
        controller.addVowel();
        controller.addConsonant();
        controller.completeLetters();

        final state = container.read(wordGameControllerProvider);
        expect(state.availableLetters.length, 8);
        expect(state.lettersReady, isTrue);
      });
    });

    group('updateGuess', () {
      test('kelime güncellemesi yapar', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('KAL');

        final state = container.read(wordGameControllerProvider);
        expect(state.currentGuess, 'KAL');
      });

      test('küçük harfler büyük harfe dönüştürülür', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('kal');

        final state = container.read(wordGameControllerProvider);
        expect(state.currentGuess, 'KAL');
      });

      test('geçersiz harf hatası gösterir', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('XYZ');

        final state = container.read(wordGameControllerProvider);
        expect(state.validationError, isNotNull);
        expect(state.invalidLetterIndices, isNotEmpty);
      });

      test('joker kullanımını tespit eder', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'İ', 'T', 'B', 'C']);
        controller.updateGuess('KALEM'); // M yok, joker gerekli

        final state = container.read(wordGameControllerProvider);
        expect(state.jokerUsed, isTrue);
        expect(state.jokerLetter, 'M');
      });

      test('harfler hazır değilse çalışmaz', () {
        controller.startManualGame();
        controller.updateGuess('TEST');

        final state = container.read(wordGameControllerProvider);
        expect(state.currentGuess, '');
      });
    });

    group('clearGuess', () {
      test('tahmin metnini temizler', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('KALEM');
        controller.clearGuess();

        final state = container.read(wordGameControllerProvider);
        expect(state.currentGuess, '');
        expect(state.jokerUsed, isFalse);
        expect(state.validationError, isNull);
      });
    });

    group('submitAnswer', () {
      test('geçerli kelime için puan hesaplar', () async {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('KALEM');
        await controller.submitAnswer();

        final state = container.read(wordGameControllerProvider);
        expect(state.status, GameStatus.submitted);
        expect(state.score, 50); // 5 harf * 10 puan
      });

      test('geçersiz kelime için 0 puan', () async {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('XY'); // 2 harf, geçersiz
        await controller.submitAnswer();

        final state = container.read(wordGameControllerProvider);
        expect(state.status, GameStatus.submitted);
        expect(state.score, 0);
      });

      test('sözlükte olmayan kelime için 0 puan', () async {
        controller.startGame(letters: ['X', 'Y', 'Z', 'A', 'B', 'C', 'D', 'E']);
        controller.updateGuess('XYZ');
        await controller.submitAnswer();

        final state = container.read(wordGameControllerProvider);
        expect(state.score, 0);
      });

      test('joker kullanıldığında 5 puan az', () async {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'İ', 'T', 'B', 'C']);
        controller.updateGuess('KALEM'); // M için joker
        await controller.submitAnswer();

        final state = container.read(wordGameControllerProvider);
        expect(state.jokerUsed, isTrue);
        expect(state.score, 45); // 4*10 + 5
      });
    });

    group('findBestWord', () {
      test('en iyi kelimeyi bulur', () async {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);

        final result = await controller.findBestWord();
        expect(result.hasWord, isTrue);
        expect(result.bestWord.isNotEmpty, isTrue);
      });
    });

    group('findTopWords', () {
      test('birden fazla kelime bulur', () async {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);

        final results = await controller.findTopWords(count: 5);
        expect(results.length, greaterThan(0));
        expect(results.length, lessThanOrEqualTo(5));
      });
    });

    group('resetGame', () {
      test('oyunu sıfırlar', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('KALEM');
        controller.resetGame();

        final state = container.read(wordGameControllerProvider);
        expect(state.currentGuess, '');
        expect(state.jokerUsed, isFalse);
        expect(state.availableLetters.length, 8); // Harfler aynı kalır
      });
    });

    group('completeGame', () {
      test('submitted state\'den completed\'a geçer', () async {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('KALEM');
        await controller.submitAnswer();
        controller.completeGame();

        final state = container.read(wordGameControllerProvider);
        expect(state.status, GameStatus.completed);
      });
    });

    group('letterUsage', () {
      test('kullanılan harfler işaretlenir', () {
        controller.startGame(letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B']);
        controller.updateGuess('KAL');

        final state = container.read(wordGameControllerProvider);
        final usedLetters = state.letterUsage.where((u) => u.isUsed).toList();

        expect(usedLetters.length, 3);
      });
    });
  });
}
