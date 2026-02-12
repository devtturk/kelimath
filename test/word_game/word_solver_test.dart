import 'package:test/test.dart';
import 'package:kelimath/features/word_game/domain/dictionary/mock_dictionary.dart';
import 'package:kelimath/features/word_game/domain/dictionary/word_solver.dart';

void main() {
  group('WordSolver', () {
    late WordSolver solver;
    late MockDictionary dictionary;

    setUp(() {
      dictionary = MockDictionary();
      solver = WordSolver(dictionary: dictionary);
    });

    group('findBestWord', () {
      test('en uzun kelimeyi bulur', () async {
        final result = await solver.findBestWord(
          letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          jokerAvailable: false,
        );

        expect(result.hasWord, isTrue);
        expect(result.bestWord.length, greaterThan(0));
        expect(result.score, greaterThan(0));
      });

      test('joker olmadan joker kullanmaz', () async {
        final result = await solver.findBestWord(
          letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          jokerAvailable: false,
        );

        expect(result.usesJoker, isFalse);
        expect(result.jokerLetter, isNull);
      });

      test('joker ile daha uzun kelime bulursa kullanır', () async {
        // Joker olmadan bulunan kelime
        final withoutJoker = await solver.findBestWord(
          letters: ['K', 'A', 'L', 'E', 'İ', 'T', 'B', 'C'],
          jokerAvailable: false,
        );

        // Joker ile
        final withJoker = await solver.findBestWord(
          letters: ['K', 'A', 'L', 'E', 'İ', 'T', 'B', 'C'],
          jokerAvailable: true,
        );

        // Joker ile daha yüksek puan olabilir
        expect(withJoker.score, greaterThanOrEqualTo(withoutJoker.score));
      });

      test('boş harflerle boş sonuç döner', () async {
        final result = await solver.findBestWord(
          letters: [],
          jokerAvailable: true,
        );

        expect(result.hasWord, isFalse);
        expect(result.bestWord, '');
        expect(result.score, 0);
      });

      test('hiç kelime bulunamazsa boş sonuç', () async {
        final result = await solver.findBestWord(
          letters: ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'],
          jokerAvailable: false,
        );

        expect(result.hasWord, isFalse);
      });

      test('joker kullanıldığında jokerLetter dolu', () async {
        // M harfi olmadan KALEM yazmaya çalış
        final result = await solver.findBestWord(
          letters: ['K', 'A', 'L', 'E', 'İ', 'T', 'B', 'C'],
          jokerAvailable: true,
        );

        if (result.usesJoker) {
          expect(result.jokerLetter, isNotNull);
          expect(result.jokerPosition, isNotNull);
        }
      });
    });

    group('findTopWords', () {
      test('birden fazla kelime döner', () async {
        final results = await solver.findTopWords(
          letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          jokerAvailable: false,
          count: 5,
        );

        expect(results.length, greaterThan(0));
        expect(results.length, lessThanOrEqualTo(5));
      });

      test('puana göre sıralı', () async {
        final results = await solver.findTopWords(
          letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          jokerAvailable: false,
          count: 5,
        );

        for (int i = 0; i < results.length - 1; i++) {
          expect(
            results[i].score,
            greaterThanOrEqualTo(results[i + 1].score),
            reason: '${results[i].bestWord} ${results[i + 1].bestWord}den önce gelmeli',
          );
        }
      });

      test('count kadar sonuç döner', () async {
        final results = await solver.findTopWords(
          letters: ['A', 'E', 'İ', 'K', 'L', 'M', 'N', 'R'],
          jokerAvailable: true,
          count: 3,
        );

        expect(results.length, lessThanOrEqualTo(3));
      });
    });

    group('validateAndScore', () {
      test('geçerli kelime doğrulanır', () async {
        final result = await solver.validateAndScore(
          word: 'KALEM',
          letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
        expect(result.score, 50); // 5 harf * 10
        expect(result.usesJoker, isFalse);
      });

      test('sözlükte olmayan kelime geçersiz', () async {
        final result = await solver.validateAndScore(
          word: 'XYZABC',
          letters: ['X', 'Y', 'Z', 'A', 'B', 'C', 'D', 'E'],
          jokerAvailable: true,
        );

        expect(result.isValid, isFalse);
        expect(result.score, 0);
      });

      test('harflerle yazılamayan kelime geçersiz', () async {
        final result = await solver.validateAndScore(
          word: 'KALEM',
          letters: ['X', 'Y', 'Z', 'A', 'B', 'C', 'D', 'E'],
          jokerAvailable: false,
        );

        expect(result.isValid, isFalse);
      });

      test('joker ile yazılabilen kelime geçerli', () async {
        // M harfi yok, joker ile tamamlanmalı
        final result = await solver.validateAndScore(
          word: 'KALEM',
          letters: ['K', 'A', 'L', 'E', 'İ', 'T', 'B', 'C'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
        expect(result.usesJoker, isTrue);
        expect(result.jokerLetter, 'M');
        expect(result.score, 45); // 4*10 + 5
      });

      test('küçük harfle yazılan kelime kabul edilir', () async {
        final result = await solver.validateAndScore(
          word: 'kalem',
          letters: ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          jokerAvailable: true,
        );

        expect(result.isValid, isTrue);
      });

      test('birden fazla eksik harf joker yetmez', () async {
        final result = await solver.validateAndScore(
          word: 'KALEM',
          letters: ['K', 'A', 'İ', 'T', 'B', 'C', 'D', 'F'],
          jokerAvailable: true,
        );

        expect(result.isValid, isFalse); // L, E, M yok - joker sadece 1
      });
    });

    group('performans', () {
      test('100 farklı harf seti hızlı çözülür', () async {
        final stopwatch = Stopwatch()..start();

        final letterSets = [
          ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          ['A', 'R', 'A', 'B', 'A', 'C', 'I', 'K'],
          ['E', 'V', 'L', 'İ', 'L', 'İ', 'K', 'T'],
          ['O', 'K', 'U', 'L', 'C', 'U', 'D', 'A'],
          ['Y', 'A', 'Z', 'I', 'L', 'I', 'M', 'C'],
        ];

        for (int i = 0; i < 100; i++) {
          final letters = letterSets[i % letterSets.length];
          await solver.findBestWord(
            letters: letters,
            jokerAvailable: true,
          );
        }

        stopwatch.stop();
        print('\n100 çözüm süresi: ${stopwatch.elapsedMilliseconds}ms');

        // 100 çözüm 3 saniyeden kısa sürmeli
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(3000),
          reason: 'Performans yetersiz',
        );
      });
    });
  });
}
