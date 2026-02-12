import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data.dart';
import '../domain/domain.dart';

// ─────────────────────────────────────────────────────────────────
// Auth Providers (Firebase tabanlı)
// ─────────────────────────────────────────────────────────────────

/// Firebase auth servisi provider.
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

/// Mevcut kullanıcı ID provider.
final currentUserIdProvider =
    NotifierProvider<CurrentUserIdNotifier, String?>(CurrentUserIdNotifier.new);

/// Kullanıcı ID notifier.
class CurrentUserIdNotifier extends Notifier<String?> {
  @override
  String? build() {
    // Firebase'den mevcut kullanıcıyı al
    final authService = ref.watch(firebaseAuthServiceProvider);
    return authService.currentUserId;
  }

  void setUserId(String userId) => state = userId;
  void clear() => state = null;
}

// ─────────────────────────────────────────────────────────────────
// Repository Provider
// ─────────────────────────────────────────────────────────────────

/// Profil repository provider - Hive kullanıyor.
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return HiveProfileRepository();
});

// ─────────────────────────────────────────────────────────────────
// User Profile Provider
// ─────────────────────────────────────────────────────────────────

/// Kullanıcı profili provider.
final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile?>(
  UserProfileNotifier.new,
);

/// Kullanıcı profil notifier.
class UserProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return null;

    final repo = ref.watch(profileRepositoryProvider);
    var profile = await repo.getUserProfile(userId);

    // Profil yoksa yeni oluştur
    if (profile == null) {
      profile = UserProfile.newUser(id: userId);
      await repo.saveUserProfile(userId, profile);
    }

    return profile;
  }

  /// Anonim giriş yap.
  Future<void> signInAnonymously() async {
    final authService = ref.read(firebaseAuthServiceProvider);
    final userId = await authService.signInAnonymously();
    ref.read(currentUserIdProvider.notifier).setUserId(userId);
  }

  /// Avatar güncelle.
  Future<void> updateAvatar(int avatarId) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final repo = ref.read(profileRepositoryProvider);
    await repo.updateAvatar(userId, avatarId);

    // State'i güncelle
    state = AsyncData(state.value?.copyWith(avatarId: avatarId));
  }

  /// Kullanıcı adını güncelle.
  Future<void> updateDisplayName(String name) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final repo = ref.read(profileRepositoryProvider);
    await repo.updateDisplayName(userId, name);

    // State'i güncelle
    state = AsyncData(state.value?.copyWith(displayName: name));
  }

  /// Son oynama tarihini güncelle.
  Future<void> updateLastPlayedAt() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final profile = state.value;
    if (profile == null) return;

    final repo = ref.read(profileRepositoryProvider);
    final updatedProfile = profile.copyWith(lastPlayedAt: DateTime.now());
    await repo.saveUserProfile(userId, updatedProfile);

    state = AsyncData(updatedProfile);
  }

  /// Tutorial'ı tamamlandı olarak işaretle.
  Future<void> completeTutorial() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final profile = state.value;
    if (profile == null) return;

    final repo = ref.read(profileRepositoryProvider);
    final updatedProfile = profile.copyWith(
      hasCompletedTutorial: true,
      tutorialCompletedAt: DateTime.now(),
    );
    await repo.saveUserProfile(userId, updatedProfile);

    state = AsyncData(updatedProfile);
  }
}

// ─────────────────────────────────────────────────────────────────
// Statistics Provider
// ─────────────────────────────────────────────────────────────────

/// İstatistikler provider.
final statisticsProvider =
    AsyncNotifierProvider<StatisticsNotifier, GameStatistics>(
  StatisticsNotifier.new,
);

/// İstatistikler notifier.
class StatisticsNotifier extends AsyncNotifier<GameStatistics> {
  @override
  Future<GameStatistics> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return GameStatistics.empty();

    final repo = ref.watch(profileRepositoryProvider);
    return repo.getStatistics(userId);
  }

  /// Oyun sonucunu kaydet ve istatistikleri güncelle.
  Future<void> recordGame(GameHistoryEntry entry) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final repo = ref.read(profileRepositoryProvider);
    final currentStats = state.value ?? GameStatistics.empty();

    // Seri hesapla
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastPlayed = currentStats.lastPlayedDate;

    int newStreak = currentStats.currentStreak;
    if (lastPlayed != null) {
      final lastDay = DateTime(
        lastPlayed.year,
        lastPlayed.month,
        lastPlayed.day,
      );
      final diff = today.difference(lastDay).inDays;
      if (diff == 1) {
        newStreak = currentStats.currentStreak + 1;
      } else if (diff > 1) {
        newStreak = 1;
      }
    } else {
      newStreak = 1;
    }

    // Kelime ve sayı istatistiklerini hesapla
    var wordStats = currentStats.wordStats;
    var numberStats = currentStats.numberStats;

    for (final round in entry.rounds) {
      final roundScore = round.score + round.timeBonus;
      if (round.isWordGame) {
        wordStats = wordStats.copyWith(
          gamesPlayed: wordStats.gamesPlayed + 1,
          totalScore: wordStats.totalScore + roundScore,
          highScore: roundScore > wordStats.highScore
              ? roundScore
              : wordStats.highScore,
          totalWordsFound: wordStats.totalWordsFound + 1,
        );
      } else {
        numberStats = numberStats.copyWith(
          gamesPlayed: numberStats.gamesPlayed + 1,
          totalScore: numberStats.totalScore + roundScore,
          highScore: roundScore > numberStats.highScore
              ? roundScore
              : numberStats.highScore,
        );
      }
    }

    final newStats = currentStats.copyWith(
      totalGamesPlayed: currentStats.totalGamesPlayed + 1,
      totalScore: currentStats.totalScore + entry.totalScore,
      highScore: entry.totalScore > currentStats.highScore
          ? entry.totalScore
          : currentStats.highScore,
      currentStreak: newStreak,
      longestStreak: newStreak > currentStats.longestStreak
          ? newStreak
          : currentStats.longestStreak,
      lastPlayedDate: now,
      wordStats: wordStats,
      numberStats: numberStats,
    );

    // Repository'ye kaydet
    await repo.updateStatistics(userId, newStats);
    await repo.recordGameResult(userId, entry);

    // State'i güncelle
    state = AsyncData(newStats);

    // Başarımları kontrol et
    ref.read(achievementsProvider.notifier).checkAndUnlock(newStats);
  }
}

// ─────────────────────────────────────────────────────────────────
// Achievements Provider
// ─────────────────────────────────────────────────────────────────

/// Başarımlar provider.
final achievementsProvider =
    AsyncNotifierProvider<AchievementsNotifier, List<Achievement>>(
  AchievementsNotifier.new,
);

/// Başarımlar notifier.
class AchievementsNotifier extends AsyncNotifier<List<Achievement>> {
  @override
  Future<List<Achievement>> build() async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) return getDefaultAchievements();

    final repo = ref.watch(profileRepositoryProvider);
    return repo.getAchievements(userId);
  }

  /// Başarımları kontrol et ve kilitleri aç.
  Future<void> checkAndUnlock(GameStatistics stats) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    final repo = ref.read(profileRepositoryProvider);
    final achievements = state.value ?? getDefaultAchievements();

    for (final achievement in achievements) {
      if (achievement.isUnlocked) continue;

      bool shouldUnlock = false;
      int progress = 0;

      switch (achievement.type) {
        case AchievementType.firstWin:
          progress = stats.totalGamesPlayed;
          shouldUnlock = stats.totalGamesPlayed >= 1;
          break;
        case AchievementType.tenGames:
          progress = stats.totalGamesPlayed;
          shouldUnlock = stats.totalGamesPlayed >= 10;
          break;
        case AchievementType.fiftyGames:
          progress = stats.totalGamesPlayed;
          shouldUnlock = stats.totalGamesPlayed >= 50;
          break;
        case AchievementType.hundredGames:
          progress = stats.totalGamesPlayed;
          shouldUnlock = stats.totalGamesPlayed >= 100;
          break;
        case AchievementType.perfectWord:
          progress = stats.wordStats.fullWordBonusCount;
          shouldUnlock = stats.wordStats.fullWordBonusCount >= 1;
          break;
        case AchievementType.perfectNumber:
          progress = stats.numberStats.exactMatchCount;
          shouldUnlock = stats.numberStats.exactMatchCount >= 1;
          break;
        case AchievementType.streakThree:
          progress = stats.currentStreak;
          shouldUnlock = stats.currentStreak >= 3;
          break;
        case AchievementType.streakSeven:
          progress = stats.currentStreak;
          shouldUnlock = stats.currentStreak >= 7;
          break;
        case AchievementType.streakThirty:
          progress = stats.currentStreak;
          shouldUnlock = stats.currentStreak >= 30;
          break;
        case AchievementType.wordMaster:
          progress = stats.wordStats.totalWordsFound;
          shouldUnlock = stats.wordStats.totalWordsFound >= 100;
          break;
        case AchievementType.numberMaster:
          progress = stats.numberStats.exactMatchCount;
          shouldUnlock = stats.numberStats.exactMatchCount >= 50;
          break;
        case AchievementType.speedDemon:
          // Bu başarım oyun içinde kontrol edilir
          break;
      }

      if (shouldUnlock) {
        await repo.unlockAchievement(userId, achievement.type);
      } else if (progress > achievement.currentProgress) {
        await repo.updateAchievementProgress(
          userId,
          achievement.type,
          progress,
        );
      }
    }

    // Başarımları yeniden yükle
    ref.invalidateSelf();
  }
}

// ─────────────────────────────────────────────────────────────────
// Game History Provider
// ─────────────────────────────────────────────────────────────────

/// Oyun geçmişi stream provider.
final gameHistoryProvider = StreamProvider<List<GameHistoryEntry>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value([]);

  final repo = ref.watch(profileRepositoryProvider);
  return repo.watchGameHistory(userId);
});
