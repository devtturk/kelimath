import 'package:flutter_test/flutter_test.dart';
import 'package:kelimath/features/number_game/domain/operation.dart';

void main() {
  group('Operation', () {
    group('apply', () {
      test('toplama doğru çalışır', () {
        expect(Operation.add.apply(10, 5), 15);
        expect(Operation.add.apply(100, 200), 300);
      });

      test('çıkarma doğru çalışır', () {
        expect(Operation.subtract.apply(10, 5), 5);
        expect(Operation.subtract.apply(100, 30), 70);
      });

      test('çarpma doğru çalışır', () {
        expect(Operation.multiply.apply(10, 5), 50);
        expect(Operation.multiply.apply(7, 8), 56);
      });

      test('bölme tam sayı sonuç verir (integer division)', () {
        expect(Operation.divide.apply(10, 5), 2);
        expect(Operation.divide.apply(100, 4), 25);
        // Kalanlı bölme - integer division
        expect(Operation.divide.apply(10, 3), 3);
      });
    });

    group('isValidDivision', () {
      test('kalansız bölme geçerlidir', () {
        expect(Operation.divide.isValidDivision(10, 5), isTrue);
        expect(Operation.divide.isValidDivision(100, 25), isTrue);
        expect(Operation.divide.isValidDivision(75, 3), isTrue);
      });

      test('kalanlı bölme geçersizdir', () {
        expect(Operation.divide.isValidDivision(10, 3), isFalse);
        expect(Operation.divide.isValidDivision(7, 2), isFalse);
      });

      test('sıfıra bölme geçersizdir', () {
        expect(Operation.divide.isValidDivision(10, 0), isFalse);
      });

      test('diğer işlemler için her zaman true döner', () {
        expect(Operation.add.isValidDivision(10, 3), isTrue);
        expect(Operation.subtract.isValidDivision(10, 3), isTrue);
        expect(Operation.multiply.isValidDivision(10, 3), isTrue);
      });
    });

    group('symbol', () {
      test('doğru sembolleri döner', () {
        expect(Operation.add.symbol, '+');
        expect(Operation.subtract.symbol, '-');
        expect(Operation.multiply.symbol, '*');
        expect(Operation.divide.symbol, '/');
      });
    });
  });
}
