import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/screens/final_result_screen.dart';

/// Oyun oturumunun durumu.
class GameSessionState {
  const GameSessionState({
    this.currentRound = 1,
    this.totalRounds = 4,
    this.roundScores = const [],
    this.startTime,
    this.isActive = false,
  });

  final int currentRound;
  final int totalRounds;
  final List<RoundScore> roundScores;
  final DateTime? startTime;
  final bool isActive;

  /// Toplam puan.
  int get totalScore => roundScores.fold(0, (sum, r) => sum + r.total);

  /// Oyun süresi.
  Duration? get totalTime =>
      startTime != null ? DateTime.now().difference(startTime!) : null;

  /// Son tur mu?
  bool get isLastRound => currentRound >= totalRounds;

  /// Oyun tamamlandı mı? (Sayı oyunu sonucu da alındıysa)
  bool get isCompleted => roundScores.length >= totalRounds;

  GameSessionState copyWith({
    int? currentRound,
    int? totalRounds,
    List<RoundScore>? roundScores,
    DateTime? startTime,
    bool? isActive,
  }) {
    return GameSessionState(
      currentRound: currentRound ?? this.currentRound,
      totalRounds: totalRounds ?? this.totalRounds,
      roundScores: roundScores ?? this.roundScores,
      startTime: startTime ?? this.startTime,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Oyun oturumunu yöneten controller.
class GameSessionController extends Notifier<GameSessionState> {
  @override
  GameSessionState build() {
    return const GameSessionState();
  }

  /// Yeni oyun başlat.
  void startGame({int totalRounds = 4}) {
    state = GameSessionState(
      currentRound: 1,
      totalRounds: totalRounds,
      roundScores: [],
      startTime: DateTime.now(),
      isActive: true,
    );
  }

  /// Kelime oyunu puanını ekle.
  void addWordScore({required int score, required int timeBonus}) {
    final newScore = RoundScore(
      isWordGame: true,
      score: score,
      timeBonus: timeBonus,
    );
    state = state.copyWith(
      roundScores: [...state.roundScores, newScore],
    );
  }

  /// Sayı oyunu puanını ekle ve bir sonraki tura geç.
  void addNumberScore({required int score, required int timeBonus}) {
    final newScore = RoundScore(
      isWordGame: false,
      score: score,
      timeBonus: timeBonus,
    );
    state = state.copyWith(
      roundScores: [...state.roundScores, newScore],
      currentRound: state.currentRound + 1,
    );
  }

  /// Oyunu sonlandır.
  void endGame() {
    state = state.copyWith(isActive: false);
  }

  /// Oturumu sıfırla.
  void reset() {
    state = const GameSessionState();
  }
}

/// GameSession provider.
final gameSessionProvider =
    NotifierProvider<GameSessionController, GameSessionState>(
  GameSessionController.new,
);
