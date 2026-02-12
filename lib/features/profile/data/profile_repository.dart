import '../domain/domain.dart';

/// Profil verileri repository arayüzü.
abstract class ProfileRepository {
  // ─────────────────────────────────────────────────────────────────
  // User Profile
  // ─────────────────────────────────────────────────────────────────

  /// Kullanıcı profilini getir.
  Future<UserProfile?> getUserProfile(String userId);

  /// Kullanıcı profilini kaydet.
  Future<void> saveUserProfile(String userId, UserProfile profile);

  /// Avatar güncelle.
  Future<void> updateAvatar(String userId, int avatarId);

  /// Kullanıcı adını güncelle.
  Future<void> updateDisplayName(String userId, String name);

  // ─────────────────────────────────────────────────────────────────
  // Statistics
  // ─────────────────────────────────────────────────────────────────

  /// İstatistikleri getir.
  Future<GameStatistics> getStatistics(String userId);

  /// İstatistikleri güncelle.
  Future<void> updateStatistics(String userId, GameStatistics stats);

  /// Oyun sonucunu kaydet.
  Future<void> recordGameResult(String userId, GameHistoryEntry entry);

  // ─────────────────────────────────────────────────────────────────
  // Achievements
  // ─────────────────────────────────────────────────────────────────

  /// Başarımları getir.
  Future<List<Achievement>> getAchievements(String userId);

  /// Başarımı kilitle aç.
  Future<void> unlockAchievement(String userId, AchievementType type);

  /// Başarım ilerlemesini güncelle.
  Future<void> updateAchievementProgress(
    String userId,
    AchievementType type,
    int progress,
  );

  // ─────────────────────────────────────────────────────────────────
  // Game History
  // ─────────────────────────────────────────────────────────────────

  /// Oyun geçmişini getir.
  Future<List<GameHistoryEntry>> getGameHistory(
    String userId, {
    int limit = 20,
  });

  /// Oyun geçmişini dinle.
  Stream<List<GameHistoryEntry>> watchGameHistory(String userId);
}
