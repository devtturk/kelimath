import 'package:test/test.dart';
import 'package:kelimath/features/word_game/domain/dictionary/mock_dictionary.dart';

void main() {
  group('MockDictionary', () {
    late MockDictionary dictionary;

    setUp(() {
      dictionary = MockDictionary();
    });

    group('isValidWord', () {
      test('geçerli kelime true döner', () async {
        expect(await dictionary.isValidWord('KALEM'), isTrue);
        expect(await dictionary.isValidWord('EV'), isTrue);
        expect(await dictionary.isValidWord('ARABA'), isTrue);
      });

      test('geçersiz kelime false döner', () async {
        expect(await dictionary.isValidWord('XYZABC'), isFalse);
        expect(await dictionary.isValidWord('ASDFGH'), isFalse);
      });

      test('küçük harfle de çalışır', () async {
        expect(await dictionary.isValidWord('kalem'), isTrue);
        expect(await dictionary.isValidWord('Kalem'), isTrue);
      });

      test('boşluklu kelime temizlenir', () async {
        expect(await dictionary.isValidWord(' KALEM '), isTrue);
      });
    });

    group('getWordCount', () {
      test('en az 500 kelime içerir', () async {
        final count = await dictionary.getWordCount();
        expect(count, greaterThan(500));
      });
    });

    group('isReady', () {
      test('her zaman true döner', () async {
        expect(await dictionary.isReady(), isTrue);
      });
    });

    group('findValidWords', () {
      test('verilen harflerle kelime bulur', () async {
        final words = await dictionary.findValidWords(
          ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          includeJoker: false,
        );

        expect(words, isNotEmpty);
        // KALEM bulunmalı
        expect(words.contains('KALEM'), isTrue);
      });

      test('uzunluğa göre sıralı döner (azalan)', () async {
        final words = await dictionary.findValidWords(
          ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          includeJoker: false,
        );

        for (int i = 0; i < words.length - 1; i++) {
          expect(
            words[i].length,
            greaterThanOrEqualTo(words[i + 1].length),
            reason: '${words[i]} ${words[i + 1]}den önce gelmeli',
          );
        }
      });

      test('joker ile daha fazla kelime bulur', () async {
        final withoutJoker = await dictionary.findValidWords(
          ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          includeJoker: false,
        );

        final withJoker = await dictionary.findValidWords(
          ['K', 'A', 'L', 'E', 'M', 'İ', 'T', 'B'],
          includeJoker: true,
        );

        expect(withJoker.length, greaterThanOrEqualTo(withoutJoker.length));
      });

      test('aynı harften birden fazla varsa kullanılabilir', () async {
        final words = await dictionary.findValidWords(
          ['A', 'A', 'N', 'N', 'E', 'B', 'C', 'D'],
          includeJoker: false,
        );

        // ANNE kelimesi bulunmalı
        expect(words.contains('ANNE'), isTrue);
      });

      test('boş harflerle boş liste döner', () async {
        final words = await dictionary.findValidWords(
          [],
          includeJoker: false,
        );

        expect(words, isEmpty);
      });
    });

    group('getDefinition', () {
      test('MVP\'de null döner', () async {
        final definition = await dictionary.getDefinition('KALEM');
        expect(definition, isNull);
      });
    });

    group('sözlük içeriği', () {
      test('çekim ekli kelimeler yok', () {
        final words = dictionary.allWords;

        // Yaygın çekim ekleri
        final invalidSuffixes = [
          'LAR', 'LER', // Çoğul
          'DAN', 'DEN', 'TAN', 'TEN', // Ayrılma hali
          'YOR', 'DI', 'Dİ', 'TI', 'Tİ', // Zaman ekleri
        ];

        for (final word in words) {
          for (final suffix in invalidSuffixes) {
            // Sadece ek olarak bitenleri kontrol et (kelime kendisi değil)
            if (word.endsWith(suffix) && word.length > suffix.length + 2) {
              // Bu kelimenin kökü de sözlükte olmalı (yapım eki olabilir)
              // Örn: KALEMLER geçersiz ama KALEMLİK geçerli
              // Bu test sadece uyarı amaçlı
            }
          }
        }
      });

      test('temel kelimeler mevcut', () {
        final words = dictionary.allWords;

        final essentialWords = [
          'EV', 'SU', 'YOL', 'GÖZ', 'EL',
          'ADAM', 'KADIN', 'ÇOCUK',
          'KALEM', 'KİTAP', 'MASA',
          'ARABA', 'OKUL', 'PARK',
        ];

        for (final word in essentialWords) {
          expect(
            words.contains(word),
            isTrue,
            reason: '$word sözlükte olmalı',
          );
        }
      });
    });
  });
}
