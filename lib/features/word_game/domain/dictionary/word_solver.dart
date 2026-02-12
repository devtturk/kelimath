import '../word_game_state.dart';
import '../word_scoring_utils.dart';
import 'word_dictionary.dart';

/// Kelime oyunu için en iyi kelime bulucu.
///
/// Verilen harflerle yazılabilecek en yüksek puanlı kelimeyi bulur.
/// Öncelik sırası:
/// 1. En yüksek puan (uzunluk + joker durumu)
/// 2. Aynı puanda: joker kullanmayan tercih edilir
class WordSolver {
  WordSolver({required WordDictionary dictionary}) : _dictionary = dictionary;

  final WordDictionary _dictionary;

  /// Verilen harflerle yazılabilecek en iyi kelimeyi bulur.
  ///
  /// [letters]: Mevcut 8 harf listesi.
  /// [jokerAvailable]: Joker kullanılabilir mi?
  ///
  /// Döndürür: [WordSolverResult] - en iyi kelime ve detaylar.
  Future<WordSolverResult> findBestWord({
    required List<String> letters,
    required bool jokerAvailable,
  }) async {
    // Önce joker olmadan dene
    final wordsWithoutJoker = await _dictionary.findValidWords(
      letters,
      includeJoker: false,
    );

    // Joker ile dene
    final wordsWithJoker = jokerAvailable
        ? await _dictionary.findValidWords(letters, includeJoker: true)
        : <String>[];

    String? bestWord;
    int bestScore = 0;
    bool usesJoker = false;
    String? jokerLetter;
    int? jokerPosition;

    // Joker olmadan en iyi kelimeyi bul
    for (final word in wordsWithoutJoker) {
      final score = WordScoringUtils.calculateWordScore(
        letterCount: word.length,
        jokerUsed: false,
      );

      if (score > bestScore) {
        bestScore = score;
        bestWord = word;
        usesJoker = false;
        jokerLetter = null;
        jokerPosition = null;
      }
    }

    // Joker ile daha iyi kelime var mı?
    if (jokerAvailable) {
      for (final word in wordsWithJoker) {
        // Bu kelime joker gerektiriyor mu?
        final needsJoker = !_canFormWithoutJoker(word, letters);

        if (needsJoker) {
          final score = WordScoringUtils.calculateWordScore(
            letterCount: word.length,
            jokerUsed: true,
          );

          if (score > bestScore) {
            bestScore = score;
            bestWord = word;
            usesJoker = true;

            // Joker hangi harf için kullanıldı?
            final jokerInfo = _findJokerLetter(word, letters);
            jokerLetter = jokerInfo.letter;
            jokerPosition = jokerInfo.position;
          }
        }
      }
    }

    return WordSolverResult(
      bestWord: bestWord ?? '',
      score: bestScore,
      usesJoker: usesJoker,
      jokerLetter: jokerLetter,
      jokerPosition: jokerPosition,
    );
  }

  /// Kelime joker olmadan oluşturulabilir mi?
  bool _canFormWithoutJoker(String word, List<String> letters) {
    final normalizedWord = _turkishToUpper(word);
    final letterPool = letters.map((l) => _turkishToUpper(l)).toList();

    for (int i = 0; i < normalizedWord.length; i++) {
      final char = normalizedWord[i];
      final index = letterPool.indexOf(char);

      if (index != -1) {
        letterPool.removeAt(index);
      } else {
        return false;
      }
    }

    return true;
  }

  /// Joker'in hangi harf için kullanıldığını bulur.
  ({String letter, int position}) _findJokerLetter(
    String word,
    List<String> letters,
  ) {
    final normalizedWord = _turkishToUpper(word);
    final letterPool = letters.map((l) => _turkishToUpper(l)).toList();

    for (int i = 0; i < normalizedWord.length; i++) {
      final char = normalizedWord[i];
      final index = letterPool.indexOf(char);

      if (index != -1) {
        letterPool.removeAt(index);
      } else {
        // Bu harf joker
        return (letter: char, position: i);
      }
    }

    // Teorik olarak buraya düşmemeli
    return (letter: '', position: -1);
  }

  /// Türkçe karakterleri doğru şekilde büyük harfe dönüştürür.
  String _turkishToUpper(String text) {
    const turkishLowerToUpper = {
      'i': 'İ',
      'ı': 'I',
      'ğ': 'Ğ',
      'ü': 'Ü',
      'ş': 'Ş',
      'ö': 'Ö',
      'ç': 'Ç',
    };

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      buffer.write(turkishLowerToUpper[char] ?? char.toUpperCase());
    }
    return buffer.toString();
  }

  /// En uzun N kelimeyi bulur (alternatif öneriler için).
  ///
  /// [letters]: Mevcut 8 harf listesi.
  /// [jokerAvailable]: Joker kullanılabilir mi?
  /// [count]: Kaç kelime döndürülecek.
  Future<List<WordSolverResult>> findTopWords({
    required List<String> letters,
    required bool jokerAvailable,
    int count = 5,
  }) async {
    final allWords = await _dictionary.findValidWords(
      letters,
      includeJoker: jokerAvailable,
    );

    final results = <WordSolverResult>[];

    for (final word in allWords) {
      final needsJoker = !_canFormWithoutJoker(word, letters);

      // Joker gerekiyorsa ama joker yoksa atla
      if (needsJoker && !jokerAvailable) continue;

      final score = WordScoringUtils.calculateWordScore(
        letterCount: word.length,
        jokerUsed: needsJoker,
      );

      String? jokerLetter;
      int? jokerPosition;

      if (needsJoker) {
        final jokerInfo = _findJokerLetter(word, letters);
        jokerLetter = jokerInfo.letter;
        jokerPosition = jokerInfo.position;
      }

      results.add(WordSolverResult(
        bestWord: word,
        score: score,
        usesJoker: needsJoker,
        jokerLetter: jokerLetter,
        jokerPosition: jokerPosition,
      ));

      if (results.length >= count) break;
    }

    // Puana göre sırala
    results.sort((a, b) => b.score.compareTo(a.score));

    return results.take(count).toList();
  }

  /// Belirli bir kelimenin geçerli olup olmadığını ve puanını hesaplar.
  Future<({bool isValid, int score, bool usesJoker, String? jokerLetter})>
      validateAndScore({
    required String word,
    required List<String> letters,
    required bool jokerAvailable,
  }) async {
    final upperWord = _turkishToUpper(word.trim());

    // Sözlükte var mı?
    final isInDictionary = await _dictionary.isValidWord(upperWord);
    if (!isInDictionary) {
      return (isValid: false, score: 0, usesJoker: false, jokerLetter: null);
    }

    // Harflerle yazılabilir mi?
    final canFormWithout = _canFormWithoutJoker(upperWord, letters);

    if (canFormWithout) {
      final score = WordScoringUtils.calculateWordScore(
        letterCount: upperWord.length,
        jokerUsed: false,
      );
      return (isValid: true, score: score, usesJoker: false, jokerLetter: null);
    }

    // Joker ile yazılabilir mi?
    if (jokerAvailable) {
      final letterPool = letters.map((l) => _turkishToUpper(l)).toList();
      var jokerUsed = false;
      String? jokerLetter;

      for (int i = 0; i < upperWord.length; i++) {
        final char = upperWord[i];
        final index = letterPool.indexOf(char);

        if (index != -1) {
          letterPool.removeAt(index);
        } else if (!jokerUsed) {
          jokerUsed = true;
          jokerLetter = char;
        } else {
          // Birden fazla eksik harf var
          return (
            isValid: false,
            score: 0,
            usesJoker: false,
            jokerLetter: null
          );
        }
      }

      final score = WordScoringUtils.calculateWordScore(
        letterCount: upperWord.length,
        jokerUsed: jokerUsed,
      );

      return (
        isValid: true,
        score: score,
        usesJoker: jokerUsed,
        jokerLetter: jokerLetter
      );
    }

    return (isValid: false, score: 0, usesJoker: false, jokerLetter: null);
  }
}
