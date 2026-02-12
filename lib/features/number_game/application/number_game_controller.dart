import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/game_step.dart';
import '../domain/number_game_state.dart';
import '../domain/number_generator.dart';
import '../domain/operation.dart';
import '../domain/scoring_utils.dart';

/// Sayı oyunu için Riverpod Notifier.
/// Oyun akışını, timer'ı ve state yönetimini kontrol eder.
class NumberGameController extends Notifier<NumberGameState> {
  Timer? _timer;
  final NumberGenerator _generator = NumberGenerator();

  @override
  NumberGameState build() {
    // Notifier dispose olduğunda timer'ı temizle.
    ref.onDispose(() {
      _timer?.cancel();
    });

    // Varsayılan başlangıç state'i.
    return const NumberGameState(
      targetNumber: 0,
      availableNumbers: [],
      initialNumbers: [],
    );
  }

  /// Oyunu belirtilen hedef ve sayılarla başlatır.
  void startGame({
    required int targetNumber,
    required List<int> availableNumbers,
  }) {
    _timer?.cancel();

    state = NumberGameState(
      targetNumber: targetNumber,
      availableNumbers: List.unmodifiable(availableNumbers),
      initialNumbers: List.unmodifiable(availableNumbers),
      status: GameStatus.playing,
      timeRemaining: ScoringUtils.roundDuration,
    );

    _startTimer();
  }

  /// Rastgele sayılar ve hedefle yeni oyun başlatır.
  void startRandomGame() {
    final gameSet = _generator.generateGameSet();
    startGame(
      targetNumber: gameSet.target,
      availableNumbers: gameSet.numbers,
    );
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

    if (state.timeRemaining <= 1) {
      // Süre doldu, otomatik submit.
      _timer?.cancel();
      submitAnswer();
      return;
    }

    state = state.copyWith(timeRemaining: state.timeRemaining - 1);
  }

  /// Kullanıcının cevabını gönderir ve puanı hesaplar.
  void submitAnswer() {
    if (state.status != GameStatus.playing) {
      return;
    }

    _timer?.cancel();

    final closest = state.closestToTarget;
    final scoreResult = ScoringUtils.calculateTotalScore(
      distance: closest.distance,
      timeRemaining: state.timeRemaining,
    );

    state = state.copyWith(
      status: GameStatus.submitted,
      score: scoreResult.baseScore,
      timeBonus: scoreResult.timeBonus,
      selectedNumberIndex: null,
      selectedOperation: null,
    );
  }

  /// Bir sayıyı seçer.
  /// - Eğer hiç sayı seçili değilse: İlk sayı olarak seçer.
  /// - Eğer ilk sayı ve operatör seçiliyse: İkinci sayı olarak işlemi uygular.
  /// - Eğer aynı sayıya tekrar tıklanırsa: Seçimi iptal eder.
  void selectNumber(int index) {
    // Oyun oynamıyorsa işlem yapma.
    if (state.status != GameStatus.playing) {
      return;
    }

    // Geçersiz index kontrolü.
    if (index < 0 || index >= state.availableNumbers.length) {
      return;
    }

    // Aynı sayıya tekrar tıklandıysa seçimi iptal et.
    if (state.selectedNumberIndex == index) {
      _clearSelection();
      return;
    }

    // İlk sayı ve operatör seçiliyse, ikinci sayı olarak işlemi uygula.
    if (state.isReadyForSecondNumber) {
      _applyOperationWithSecondNumber(index);
      return;
    }

    // İlk sayı olarak seç.
    state = state.copyWith(selectedNumberIndex: index);
  }

  /// Operatör seçer.
  /// İlk sayı seçili değilse hiçbir şey yapmaz.
  void selectOperation(Operation operation) {
    // Oyun oynamıyorsa işlem yapma.
    if (state.status != GameStatus.playing) {
      return;
    }

    // İlk sayı seçili değilse işlem yapma.
    if (!state.hasSelectedNumber) {
      return;
    }

    // Aynı operatöre tekrar tıklandıysa seçimi iptal et.
    if (state.selectedOperation == operation) {
      state = state.copyWith(selectedOperation: null);
      return;
    }

    state = state.copyWith(selectedOperation: operation);
  }

  /// İkinci sayı seçildiğinde işlemi uygular.
  void _applyOperationWithSecondNumber(int secondIndex) {
    final firstIndex = state.selectedNumberIndex!;
    final operation = state.selectedOperation!;

    final firstNumber = state.availableNumbers[firstIndex];
    final secondNumber = state.availableNumbers[secondIndex];

    // İşlem geçerlilik kontrolü.
    final validationResult = _validateOperation(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      operation: operation,
    );

    if (!validationResult.isValid) {
      // Geçersiz işlem - seçimi temizle.
      _clearSelection();
      return;
    }

    final result = operation.apply(firstNumber, secondNumber);

    // Yeni available numbers listesi oluştur.
    final newAvailableNumbers = <int>[];
    for (int i = 0; i < state.availableNumbers.length; i++) {
      if (i != firstIndex && i != secondIndex) {
        newAvailableNumbers.add(state.availableNumbers[i]);
      }
    }
    newAvailableNumbers.add(result);

    // GameStep oluştur (undo için).
    final step = GameStep(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      operation: operation,
      result: result,
      previousAvailableNumbers: state.availableNumbers,
    );

    // State'i güncelle.
    state = state.copyWith(
      availableNumbers: List.unmodifiable(newAvailableNumbers),
      history: List.unmodifiable([...state.history, step]),
      selectedNumberIndex: null,
      selectedOperation: null,
    );

    // Hedef bulunduysa otomatik submit.
    if (state.isSolved) {
      submitAnswer();
    }
  }

  /// İşlemin geçerli olup olmadığını kontrol eder.
  ({bool isValid, String? errorMessage}) _validateOperation({
    required int firstNumber,
    required int secondNumber,
    required Operation operation,
  }) {
    // Bölme: Kalansız olmalı.
    if (!operation.isValidDivision(firstNumber, secondNumber)) {
      return (isValid: false, errorMessage: 'Bölme kalansız olmalı');
    }

    final result = operation.apply(firstNumber, secondNumber);

    // Sonuç 0 olamaz.
    if (result == 0) {
      return (isValid: false, errorMessage: 'Sonuç 0 olamaz');
    }

    // Sonuç negatif olamaz.
    if (result < 0) {
      return (isValid: false, errorMessage: 'Sonuç negatif olamaz');
    }

    return (isValid: true, errorMessage: null);
  }

  /// Seçimi temizler.
  void _clearSelection() {
    state = state.copyWith(
      selectedNumberIndex: null,
      selectedOperation: null,
    );
  }

  /// Son işlemi geri alır.
  void undo() {
    if (!state.canUndo) {
      return;
    }

    final lastStep = state.history.last;
    final newHistory = state.history.sublist(0, state.history.length - 1);

    state = state.copyWith(
      availableNumbers: List.unmodifiable(lastStep.previousAvailableNumbers),
      history: List.unmodifiable(newHistory),
      selectedNumberIndex: null,
      selectedOperation: null,
    );
  }

  /// Oyunu sıfırlar (aynı hedef ve başlangıç sayılarıyla).
  void resetGame() {
    if (state.status != GameStatus.playing) {
      return;
    }

    state = state.copyWith(
      availableNumbers: state.initialNumbers,
      history: const [],
      selectedNumberIndex: null,
      selectedOperation: null,
    );
  }

  /// Sonuç ekranını kapatır ve oyunu tamamlar.
  void completeGame() {
    if (state.status == GameStatus.submitted) {
      state = state.copyWith(status: GameStatus.completed);
    }
  }
}

/// NumberGameController için Riverpod provider.
final numberGameControllerProvider =
    NotifierProvider<NumberGameController, NumberGameState>(
  NumberGameController.new,
);
