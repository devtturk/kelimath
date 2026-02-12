import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_step.dart';
import 'operation.dart';

part 'number_game_state.freezed.dart';

/// Oyun durumu enum'ı.
enum GameStatus {
  /// Oyun henüz başlamadı.
  notStarted,

  /// Oyun devam ediyor.
  playing,

  /// Süre doldu veya kullanıcı gönderdi.
  submitted,

  /// Oyun tamamlandı (sonuç gösteriliyor).
  completed,
}

/// Sayı oyununun tüm durumunu temsil eden immutable state sınıfı.
@freezed
abstract class NumberGameState with _$NumberGameState {
  const NumberGameState._();

  const factory NumberGameState({
    /// Ulaşılması gereken hedef sayı (100-999 arası, asal olmayan).
    required int targetNumber,

    /// Şu an kullanılabilir sayılar listesi.
    /// İşlem yapıldıkça kullanılan sayılar silinir, sonuç eklenir.
    required List<int> availableNumbers,

    /// Oyunun başlangıcındaki sayılar (reset için).
    required List<int> initialNumbers,

    /// Yapılan işlemlerin geçmişi (undo ve adım sayısı için).
    @Default([]) List<GameStep> history,

    /// Seçili olan ilk sayının index'i (UI highlight için).
    int? selectedNumberIndex,

    /// Seçili operatör.
    Operation? selectedOperation,

    /// Kalan süre (saniye). Varsayılan 90 saniye.
    @Default(90) int timeRemaining,

    /// Oyun durumu.
    @Default(GameStatus.notStarted) GameStatus status,

    /// Kazanılan puan (submit sonrası hesaplanır).
    @Default(0) int score,

    /// Zaman bonusu (submit sonrası hesaplanır).
    @Default(0) int timeBonus,
  }) = _NumberGameState;

  /// Hedef sayıya tam olarak ulaşılıp ulaşılmadığını kontrol eder.
  bool get isSolved => availableNumbers.contains(targetNumber);

  /// Yapılan toplam işlem (adım) sayısı.
  int get stepCount => history.length;

  /// Hedefe en yakın sayıyı ve uzaklığını hesaplar.
  ({int closestNumber, int distance}) get closestToTarget {
    if (availableNumbers.isEmpty) {
      return (closestNumber: 0, distance: targetNumber);
    }

    int closest = availableNumbers.first;
    int minDistance = (closest - targetNumber).abs();

    for (final number in availableNumbers) {
      final distance = (number - targetNumber).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closest = number;
      }
    }

    return (closestNumber: closest, distance: minDistance);
  }

  /// İlk sayı seçili mi?
  bool get hasSelectedNumber => selectedNumberIndex != null;

  /// Operatör seçili mi?
  bool get hasSelectedOperation => selectedOperation != null;

  /// İşlem uygulamaya hazır mı? (İlk sayı ve operatör seçili)
  bool get isReadyForSecondNumber =>
      hasSelectedNumber && hasSelectedOperation;

  /// Geri alma yapılabilir mi?
  bool get canUndo => history.isNotEmpty && status == GameStatus.playing;

  /// Oyun oynama durumunda mı?
  bool get isPlaying => status == GameStatus.playing;

  /// Oyun gönderildi mi?
  bool get isSubmitted =>
      status == GameStatus.submitted || status == GameStatus.completed;

  /// Toplam puan (işlem puanı + zaman bonusu).
  int get totalScore => score + timeBonus;
}
