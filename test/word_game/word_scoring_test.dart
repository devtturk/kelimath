import 'package:test/test.dart';
import 'package:kelimath/features/word_game/domain/word_scoring_utils.dart';

void main() {
  group('WordScoringUtils', () {
    group('calculateWordScore', () {
      test('3 harfli kelime = 30 puan', () {
        final score = WordScoringUtils.calculateWordScore(
          letterCount: 3,
          jokerUsed: false,
        );
        expect(score, 30);
      });

      test('5 harfli kelime = 50 puan', () {
        final score = WordScoringUtils.calculateWordScore(
          letterCount: 5,
          jokerUsed: false,
        );
        expect(score, 50);
      });

      test('8 harfli kelime = 80 puan', () {
        final score = WordScoringUtils.calculateWordScore(
          letterCount: 8,
          jokerUsed: false,
        );
        expect(score, 80);
      });

      test('joker kullanımı 5 puan az verir', () {
        // 5 harfli kelime joker olmadan: 50 puan
        // 5 harfli kelime joker ile: 4*10 + 5 = 45 puan
        final withoutJoker = WordScoringUtils.calculateWordScore(
          letterCount: 5,
          jokerUsed: false,
        );
        final withJoker = WordScoringUtils.calculateWordScore(
          letterCount: 5,
          jokerUsed: true,
        );

        expect(withoutJoker, 50);
        expect(withJoker, 45);
        expect(withoutJoker - withJoker, 5);
      });

      test('9 harfli tam kelime (joker ile) = 120 puan bonus', () {
        final score = WordScoringUtils.calculateWordScore(
          letterCount: 9,
          jokerUsed: true,
        );
        expect(score, 120);
      });

      test('9 harfli kelime joker olmadan normal hesaplanır', () {
        // Teorik olarak 9 harf joker olmadan mümkün değil ama test için
        final score = WordScoringUtils.calculateWordScore(
          letterCount: 9,
          jokerUsed: false,
        );
        expect(score, 90); // 9 * 10
      });

      test('minimum 3 harften az kelime 0 puan', () {
        expect(
          WordScoringUtils.calculateWordScore(letterCount: 2, jokerUsed: false),
          0,
        );
        expect(
          WordScoringUtils.calculateWordScore(letterCount: 1, jokerUsed: false),
          0,
        );
        expect(
          WordScoringUtils.calculateWordScore(letterCount: 0, jokerUsed: false),
          0,
        );
      });
    });

    group('isFullWord', () {
      test('9 harf + joker = tam kelime', () {
        expect(WordScoringUtils.isFullWord(9, true), isTrue);
      });

      test('9 harf joker olmadan = tam kelime değil', () {
        expect(WordScoringUtils.isFullWord(9, false), isFalse);
      });

      test('8 harf + joker = tam kelime değil', () {
        expect(WordScoringUtils.isFullWord(8, true), isFalse);
      });
    });

    group('calculateTimeBonus', () {
      test('geçerli kelime için zaman bonusu verilir', () {
        final bonus = WordScoringUtils.calculateTimeBonus(30, 50);
        expect(bonus, 30);
      });

      test('0 puanlı kelime için bonus yok', () {
        final bonus = WordScoringUtils.calculateTimeBonus(30, 0);
        expect(bonus, 0);
      });

      test('negatif puan için bonus yok', () {
        final bonus = WordScoringUtils.calculateTimeBonus(30, -10);
        expect(bonus, 0);
      });

      test('60 saniyeden fazla süre clip edilir', () {
        final bonus = WordScoringUtils.calculateTimeBonus(100, 50);
        expect(bonus, 60);
      });

      test('negatif süre 0 olur', () {
        final bonus = WordScoringUtils.calculateTimeBonus(-5, 50);
        expect(bonus, 0);
      });
    });

    group('calculateTotalScore', () {
      test('5 harfli kelime, 30 saniye kalan', () {
        final result = WordScoringUtils.calculateTotalScore(
          letterCount: 5,
          jokerUsed: false,
          timeRemaining: 30,
        );

        expect(result.baseScore, 50);
        expect(result.timeBonus, 30);
        expect(result.total, 80);
      });

      test('9 harfli tam kelime bonus, 45 saniye kalan', () {
        final result = WordScoringUtils.calculateTotalScore(
          letterCount: 9,
          jokerUsed: true,
          timeRemaining: 45,
        );

        expect(result.baseScore, 120);
        expect(result.timeBonus, 45);
        expect(result.total, 165);
      });

      test('geçersiz kelime (2 harf) için 0 puan', () {
        final result = WordScoringUtils.calculateTotalScore(
          letterCount: 2,
          jokerUsed: false,
          timeRemaining: 50,
        );

        expect(result.baseScore, 0);
        expect(result.timeBonus, 0);
        expect(result.total, 0);
      });
    });

    group('getScoreBreakdown', () {
      test('normal kelime breakdown', () {
        final breakdown = WordScoringUtils.getScoreBreakdown(
          letterCount: 5,
          jokerUsed: false,
        );

        expect(breakdown.normalLetterCount, 5);
        expect(breakdown.normalLetterScore, 50);
        expect(breakdown.hasJoker, isFalse);
        expect(breakdown.jokerScoreValue, 0);
        expect(breakdown.isFullWordBonus, isFalse);
        expect(breakdown.baseScore, 50);
      });

      test('jokerli kelime breakdown', () {
        final breakdown = WordScoringUtils.getScoreBreakdown(
          letterCount: 5,
          jokerUsed: true,
        );

        expect(breakdown.normalLetterCount, 4);
        expect(breakdown.normalLetterScore, 40);
        expect(breakdown.hasJoker, isTrue);
        expect(breakdown.jokerScoreValue, 5);
        expect(breakdown.isFullWordBonus, isFalse);
        expect(breakdown.baseScore, 45);
      });

      test('9 harfli bonus breakdown', () {
        final breakdown = WordScoringUtils.getScoreBreakdown(
          letterCount: 9,
          jokerUsed: true,
        );

        expect(breakdown.normalLetterCount, 8);
        expect(breakdown.isFullWordBonus, isTrue);
        expect(breakdown.baseScore, 120);
      });

      test('geçersiz kelime breakdown', () {
        final breakdown = WordScoringUtils.getScoreBreakdown(
          letterCount: 2,
          jokerUsed: false,
        );

        expect(breakdown.normalLetterCount, 0);
        expect(breakdown.baseScore, 0);
      });
    });
  });
}
