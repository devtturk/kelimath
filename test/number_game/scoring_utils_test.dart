import 'package:flutter_test/flutter_test.dart';
import 'package:kelimath/features/number_game/domain/scoring_utils.dart';

void main() {
  group('ScoringUtils', () {
    group('calculateBaseScore', () {
      test('tam eşleşme (mesafe 0) 100 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(0), 100);
      });

      test('mesafe 1 için 90 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(1), 90);
      });

      test('mesafe 2 için 80 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(2), 80);
      });

      test('mesafe 5 için 50 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(5), 50);
      });

      test('mesafe 9 için 10 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(9), 10);
      });

      test('mesafe 10 için 0 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(10), 0);
      });

      test('mesafe 10+ için 0 puan verir', () {
        expect(ScoringUtils.calculateBaseScore(15), 0);
        expect(ScoringUtils.calculateBaseScore(100), 0);
      });

      test('negatif mesafe için hata fırlatır', () {
        expect(
          () => ScoringUtils.calculateBaseScore(-1),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('calculateTimeBonus', () {
      test('geçerli puan varsa kalan süreyi bonus olarak verir', () {
        expect(ScoringUtils.calculateTimeBonus(30, 100), 30);
        expect(ScoringUtils.calculateTimeBonus(45, 50), 45);
      });

      test('puan 0 ise zaman bonusu 0 olur', () {
        expect(ScoringUtils.calculateTimeBonus(30, 0), 0);
      });

      test('negatif süre için 0 döner', () {
        expect(ScoringUtils.calculateTimeBonus(-5, 100), 0);
      });
    });

    group('calculateTotalScore', () {
      test('tam eşleşme + 30 saniye = 130 puan', () {
        final result = ScoringUtils.calculateTotalScore(
          distance: 0,
          timeRemaining: 30,
        );

        expect(result.baseScore, 100);
        expect(result.timeBonus, 30);
        expect(result.totalScore, 130);
      });

      test('mesafe 5 + 20 saniye = 70 puan', () {
        final result = ScoringUtils.calculateTotalScore(
          distance: 5,
          timeRemaining: 20,
        );

        expect(result.baseScore, 50);
        expect(result.timeBonus, 20);
        expect(result.totalScore, 70);
      });

      test('mesafe 10+ ise zaman bonusu da 0', () {
        final result = ScoringUtils.calculateTotalScore(
          distance: 15,
          timeRemaining: 60,
        );

        expect(result.baseScore, 0);
        expect(result.timeBonus, 0);
        expect(result.totalScore, 0);
      });
    });
  });
}
