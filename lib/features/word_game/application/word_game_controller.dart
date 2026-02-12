import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/domain.dart';
import 'dictionary_provider.dart';

/// Kelime oyunu için Riverpod Notifier.
/// Oyun akışını, timer'ı ve state yönetimini kontrol eder.
class WordGameController extends Notifier<WordGameState> {
  Timer? _timer;
  final LetterGenerator _generator = LetterGenerator();
  late final WordDictionary _dictionary;
  late final WordSolver _solver;

  @override
  WordGameState build() {
    // Dictionary ve solver'ı provider'dan al.
    _dictionary = ref.watch(dictionaryProvider);
    _solver = WordSolver(dictionary: _dictionary);

    // Notifier dispose olduğunda timer'ı temizle.
    ref.onDispose(() {
      _timer?.cancel();
    });

    // Varsayılan başlangıç state'i.
    return const WordGameState(
      availableLetters: [],
      currentGuess: '',
      jokerUsed: false,
    );
  }

  /// Oyunu belirtilen harflerle başlatır.
  void startGame({List<String>? letters}) {
    _timer?.cancel();

    final gameLetters = letters ?? _generator.generateRandomLetters();

    state = WordGameState(
      availableLetters: List.unmodifiable(gameLetters),
      currentGuess: '',
      jokerUsed: false,
      jokerLetter: null,
      letterUsage: _createInitialLetterUsage(gameLetters),
      status: GameStatus.playing,
      timeRemaining: WordScoringUtils.roundDuration,
      lettersReady: true,
    );

    _startTimer();
  }

  /// Rastgele harflerle yeni oyun başlatır.
  void startRandomGame() {
    final letters = _generator.generateRandomLetters();
    startGame(letters: letters);
  }

  /// Manuel harf seçimi için oyunu başlatır (harfler boş).
  void startManualGame() {
    _timer?.cancel();

    state = const WordGameState(
      availableLetters: [],
      currentGuess: '',
      jokerUsed: false,
      jokerLetter: null,
      letterUsage: [],
      status: GameStatus.playing,
      timeRemaining: WordScoringUtils.roundDuration,
      lettersReady: false,
    );
  }

  /// Mevcut harflere sesli harf ekler.
  void addVowel() {
    if (state.status != GameStatus.playing) return;
    if (state.availableLetters.length >= 8) return;

    final newLetter = _generator.drawVowel();
    final newLetters = [...state.availableLetters, newLetter];

    state = state.copyWith(
      availableLetters: List.unmodifiable(newLetters),
      letterUsage: _createInitialLetterUsage(newLetters),
      lettersReady: newLetters.length == 8,
    );

    // 8 harf tamamlandıysa timer'ı başlat.
    if (newLetters.length == 8) {
      _startTimer();
    }
  }

  /// Mevcut harflere sessiz harf ekler.
  void addConsonant() {
    if (state.status != GameStatus.playing) return;
    if (state.availableLetters.length >= 8) return;

    final newLetter = _generator.drawConsonant();
    final newLetters = [...state.availableLetters, newLetter];

    state = state.copyWith(
      availableLetters: List.unmodifiable(newLetters),
      letterUsage: _createInitialLetterUsage(newLetters),
      lettersReady: newLetters.length == 8,
    );

    // 8 harf tamamlandıysa timer'ı başlat.
    if (newLetters.length == 8) {
      _startTimer();
    }
  }

  /// Kalan harfleri rastgele tamamlar (3-4 sesli kuralına uygun).
  void completeLetters() {
    if (state.status != GameStatus.playing) return;
    if (state.availableLetters.length >= 8) return;

    final completedLetters = _generator.completeLetters(
      List.from(state.availableLetters),
    );

    state = state.copyWith(
      availableLetters: List.unmodifiable(completedLetters),
      letterUsage: _createInitialLetterUsage(completedLetters),
      lettersReady: true,
    );

    _startTimer();
  }

  /// Timer'ı başlatır.
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  /// Her saniye çağrılır.
  void _tick() {
    if (state.status != GameStatus.playing) {
      _timer?.cancel();
      return;
    }

    // Harfler hazır değilse timer çalışmasın.
    if (!state.lettersReady) {
      return;
    }

    if (state.timeRemaining <= 1) {
      // Süre doldu - önce timeRemaining'i 0 yap, sonra submit et.
      _timer?.cancel();
      state = state.copyWith(timeRemaining: 0);
      submitAnswer();
      return;
    }

    state = state.copyWith(timeRemaining: state.timeRemaining - 1);
  }

  /// Kullanıcının yazdığı kelimeyi günceller.
  void updateGuess(String text) {
    if (state.status != GameStatus.playing) return;
    if (!state.lettersReady) return;
    if (text.length > 20) return;

    final upperText = _turkishToUpper(text);

    // Harf validasyonu yap.
    // Not: Joker her zaman kullanılabilir (oyun başında 1 joker verilir).
    // Validasyon sırasında joker ihtiyacı hesaplanır, bu yüzden her zaman true.
    final validationResult = LetterValidation.validate(
      guess: upperText,
      availableLetters: state.availableLetters,
      jokerAvailable: true,
    );

    // Harf kullanımını hesapla.
    final letterUsage = LetterValidation.calculateLetterUsage(
      guess: upperText,
      availableLetters: state.availableLetters,
    );

    state = state.copyWith(
      currentGuess: upperText,
      letterUsage: letterUsage,
      jokerUsed: validationResult.jokerUsed,
      jokerLetter: validationResult.jokerLetter,
      validationError: validationResult.isValid ? null : validationResult.errorMessage,
      invalidLetterIndices: validationResult.invalidLetterIndices,
    );
  }

  /// Tahmin metnini temizler.
  void clearGuess() {
    if (state.status != GameStatus.playing) return;

    state = state.copyWith(
      currentGuess: '',
      letterUsage: _createInitialLetterUsage(state.availableLetters),
      jokerUsed: false,
      jokerLetter: null,
      validationError: null,
      invalidLetterIndices: const [],
      selectedWordIndex: null,
    );
  }

  /// Mevcut kelimeyi listeye ekler.
  void addCurrentWordToList() {
    if (state.status != GameStatus.playing) return;
    if (!state.canAddWord) return;

    // Aynı kelime zaten listede mi kontrol et.
    final alreadyExists = state.triedWords.any(
      (w) => w.word == state.currentGuess,
    );
    if (alreadyExists) return;

    // Tahmini puanı hesapla.
    final estimatedScore = WordScoringUtils.calculateBaseScore(
      letterCount: state.currentGuess.length,
      jokerUsed: state.jokerUsed,
    );

    final newWord = TriedWord(
      word: state.currentGuess,
      jokerUsed: state.jokerUsed,
      jokerLetter: state.jokerLetter,
      estimatedScore: estimatedScore,
    );

    final newList = [...state.triedWords, newWord];

    state = state.copyWith(
      triedWords: newList,
      selectedWordIndex: newList.length - 1, // Yeni eklenen kelimeyi seç
      currentGuess: '',
      letterUsage: _createInitialLetterUsage(state.availableLetters),
      jokerUsed: false,
      jokerLetter: null,
      validationError: null,
      invalidLetterIndices: const [],
    );
  }

  /// Listeden bir kelime seçer.
  void selectWord(int index) {
    if (state.status != GameStatus.playing) return;
    if (index < 0 || index >= state.triedWords.length) return;

    state = state.copyWith(selectedWordIndex: index);
  }

  /// Seçili kelimeyi kaldırır (seçimi iptal eder).
  void deselectWord() {
    if (state.status != GameStatus.playing) return;

    state = state.copyWith(selectedWordIndex: null);
  }

  /// Listeden bir kelimeyi siler.
  void removeWord(int index) {
    if (state.status != GameStatus.playing) return;
    if (index < 0 || index >= state.triedWords.length) return;

    final newList = [...state.triedWords]..removeAt(index);

    // Seçili kelime indeksini güncelle.
    int? newSelectedIndex = state.selectedWordIndex;
    if (state.selectedWordIndex != null) {
      if (state.selectedWordIndex == index) {
        // Seçili kelime silindi.
        newSelectedIndex = newList.isNotEmpty ? newList.length - 1 : null;
      } else if (state.selectedWordIndex! > index) {
        // Seçili kelimeden önceki bir kelime silindi.
        newSelectedIndex = state.selectedWordIndex! - 1;
      }
    }

    state = state.copyWith(
      triedWords: newList,
      selectedWordIndex: newSelectedIndex,
    );
  }

  /// Kullanıcının cevabını gönderir ve puanı hesaplar.
  Future<void> submitAnswer() async {
    if (state.status != GameStatus.playing) return;

    _timer?.cancel();

    // Gönderilecek kelimeyi belirle.
    String wordToSubmit;
    bool jokerUsed;

    if (state.selectedWordIndex != null &&
        state.selectedWordIndex! < state.triedWords.length) {
      // Listeden seçili kelime.
      final selected = state.triedWords[state.selectedWordIndex!];
      wordToSubmit = selected.word;
      jokerUsed = selected.jokerUsed;
    } else if (state.currentGuess.length >= 3 &&
        state.validationError == null) {
      // Mevcut yazılan kelime.
      wordToSubmit = state.currentGuess;
      jokerUsed = state.jokerUsed;
    } else if (state.triedWords.isNotEmpty) {
      // Hiçbir şey seçili değilse en uzun kelimeyi gönder.
      final bestWord = state.triedWords.reduce(
        (a, b) => a.word.length >= b.word.length ? a : b,
      );
      wordToSubmit = bestWord.word;
      jokerUsed = bestWord.jokerUsed;
    } else {
      // Hiç kelime yok - 0 puan.
      final bestResult = await findBestWord();
      state = state.copyWith(
        status: GameStatus.submitted,
        score: 0,
        timeBonus: 0,
        bestPossibleWord: bestResult.hasWord ? bestResult.bestWord : null,
      );
      return;
    }

    // Kelime sözlükte var mı kontrol et.
    final isValidWord = await _dictionary.isValidWord(wordToSubmit);

    if (!isValidWord) {
      // Geçersiz kelime - 0 puan.
      final bestResult = await findBestWord();
      state = state.copyWith(
        status: GameStatus.submitted,
        score: 0,
        timeBonus: 0,
        currentGuess: wordToSubmit, // Gönderilen kelimeyi kaydet
        bestPossibleWord: bestResult.hasWord ? bestResult.bestWord : null,
      );
      return;
    }

    // Geçerli kelime - puan hesapla.
    final scoreResult = WordScoringUtils.calculateTotalScore(
      letterCount: wordToSubmit.length,
      jokerUsed: jokerUsed,
      timeRemaining: state.timeRemaining,
    );

    // En iyi kelimeyi bul (solver ile).
    final bestResult = await findBestWord();

    state = state.copyWith(
      status: GameStatus.submitted,
      score: scoreResult.baseScore,
      timeBonus: scoreResult.timeBonus,
      currentGuess: wordToSubmit, // Gönderilen kelimeyi kaydet
      bestPossibleWord: bestResult.hasWord ? bestResult.bestWord : null,
    );
  }

  /// En iyi kelimeyi bulur (solver kullanarak).
  Future<WordSolverResult> findBestWord() async {
    try {
      return await _solver.findBestWord(
        letters: state.availableLetters,
        jokerAvailable: true,
      );
    } catch (e) {
      debugPrint('Solver hatası: $e');
      return const WordSolverResult(bestWord: '', score: 0, usesJoker: false);
    }
  }

  /// En iyi N kelimeyi bulur.
  Future<List<WordSolverResult>> findTopWords({int count = 5}) async {
    return _solver.findTopWords(
      letters: state.availableLetters,
      jokerAvailable: true,
      count: count,
    );
  }

  /// Oyunu sıfırlar (aynı harflerle).
  void resetGame() {
    if (state.status != GameStatus.playing) return;

    state = state.copyWith(
      currentGuess: '',
      jokerUsed: false,
      jokerLetter: null,
      letterUsage: _createInitialLetterUsage(state.availableLetters),
      validationError: null,
      invalidLetterIndices: const [],
    );
  }

  /// Sonuç ekranını kapatır ve oyunu tamamlar.
  void completeGame() {
    if (state.status == GameStatus.submitted) {
      state = state.copyWith(status: GameStatus.completed);
    }
  }

  /// Başlangıç harf kullanımı listesi oluşturur.
  List<LetterUse> _createInitialLetterUsage(List<String> letters) {
    return letters
        .asMap()
        .entries
        .map((e) => LetterUse(
              letter: e.value,
              isUsed: false,
              positionInGuess: null,
            ))
        .toList();
  }

  /// Türkçe karakterleri doğru şekilde büyük harfe dönüştürür.
  /// Dart'ın toUpperCase() metodu Türkçe i/ı dönüşümünü doğru yapmaz.
  String _turkishToUpper(String text) {
    const turkishLowerToUpper = {
      'i': 'İ', // noktalı i -> noktalı İ
      'ı': 'I', // noktasız ı -> noktasız I
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
}

/// WordGameController için Riverpod provider.
final wordGameControllerProvider =
    NotifierProvider<WordGameController, WordGameState>(
  WordGameController.new,
);
