import 'dart:async';

import 'package:hive/hive.dart';

import '../domain/domain.dart';
import 'profile_repository.dart';

/// Hive tabanlı profil repository implementasyonu.
/// Android ve iOS için production-ready.
class HiveProfileRepository implements ProfileRepository {
  static const String _profileBoxName = 'user_profile';
  static const String _statsBoxName = 'statistics';
  static const String _achievementsBoxName = 'achievements';
  static const String _historyBoxName = 'game_history';

  Box get _profileBox => Hive.box(_profileBoxName);
  Box get _statsBox => Hive.box(_statsBoxName);
  Box get _achievementsBox => Hive.box(_achievementsBoxName);
  Box get _historyBox => Hive.box(_historyBoxName);

  // Stream controller for game history
  final _historyController =
      StreamController<List<GameHistoryEntry>>.broadcast();

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    final json = _profileBox.get(userId);
    if (json == null) return null;

    try {
      final Map<String, dynamic> data = Map<String, dynamic>.from(json);
      return UserProfile.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveUserProfile(String userId, UserProfile profile) async {
    await _profileBox.put(userId, profile.toJson());
  }

  @override
  Future<void> updateAvatar(String userId, int avatarId) async {
    final profile = await getUserProfile(userId);
    if (profile != null) {
      await saveUserProfile(userId, profile.copyWith(avatarId: avatarId));
    }
  }

  @override
  Future<void> updateDisplayName(String userId, String name) async {
    final profile = await getUserProfile(userId);
    if (profile != null) {
      await saveUserProfile(userId, profile.copyWith(displayName: name));
    }
  }

  @override
  Future<GameStatistics> getStatistics(String userId) async {
    final json = _statsBox.get(userId);
    if (json == null) return GameStatistics.empty();

    try {
      final Map<String, dynamic> data = Map<String, dynamic>.from(json);
      return GameStatistics.fromJson(data);
    } catch (e) {
      return GameStatistics.empty();
    }
  }

  @override
  Future<void> updateStatistics(String userId, GameStatistics stats) async {
    await _statsBox.put(userId, stats.toJson());
  }

  @override
  Future<void> recordGameResult(String userId, GameHistoryEntry entry) async {
    final historyKey = '${userId}_history';
    final existingJson = _historyBox.get(historyKey);

    List<Map<String, dynamic>> history = [];
    if (existingJson != null) {
      final List<dynamic> existing = existingJson as List<dynamic>;
      history = existing.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    // Yeni entry'yi başa ekle
    history.insert(0, entry.toJson());

    // Son 100 oyunu tut
    if (history.length > 100) {
      history = history.take(100).toList();
    }

    await _historyBox.put(historyKey, history);

    // Stream'i güncelle
    _notifyHistoryListeners(userId);
  }

  @override
  Future<List<Achievement>> getAchievements(String userId) async {
    final json = _achievementsBox.get(userId);
    if (json == null) return getDefaultAchievements();

    try {
      final List<dynamic> data = json as List<dynamic>;
      return data.map((e) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(e);
        return Achievement.fromJson(map);
      }).toList();
    } catch (e) {
      return getDefaultAchievements();
    }
  }

  @override
  Future<void> unlockAchievement(String userId, AchievementType type) async {
    final achievements = await getAchievements(userId);
    final index = achievements.indexWhere((a) => a.type == type);

    if (index >= 0) {
      achievements[index] = achievements[index].copyWith(
        isUnlocked: true,
        unlockedAt: DateTime.now(),
      );
      await _saveAchievements(userId, achievements);
    }
  }

  @override
  Future<void> updateAchievementProgress(
    String userId,
    AchievementType type,
    int progress,
  ) async {
    final achievements = await getAchievements(userId);
    final index = achievements.indexWhere((a) => a.type == type);

    if (index >= 0) {
      achievements[index] = achievements[index].copyWith(
        currentProgress: progress,
      );
      await _saveAchievements(userId, achievements);
    }
  }

  Future<void> _saveAchievements(
    String userId,
    List<Achievement> achievements,
  ) async {
    final json = achievements.map((a) => a.toJson()).toList();
    await _achievementsBox.put(userId, json);
  }

  @override
  Future<List<GameHistoryEntry>> getGameHistory(
    String userId, {
    int limit = 20,
  }) async {
    final historyKey = '${userId}_history';
    final json = _historyBox.get(historyKey);

    if (json == null) return [];

    try {
      final List<dynamic> data = json as List<dynamic>;
      return data.take(limit).map((e) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(e);
        return GameHistoryEntry.fromJson(map);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Stream<List<GameHistoryEntry>> watchGameHistory(String userId) {
    // İlk değeri yayınla
    _notifyHistoryListeners(userId);
    return _historyController.stream;
  }

  void _notifyHistoryListeners(String userId) async {
    final history = await getGameHistory(userId);
    _historyController.add(history);
  }

  /// Repository'yi kapat
  void dispose() {
    _historyController.close();
  }
}

/// Hive tabanlı Auth Service.
/// Kullanıcı ID'sini lokalde saklar.
class HiveAuthService {
  static const String _authBoxName = 'user_profile';
  static const String _currentUserKey = 'current_user_id';

  Box get _authBox => Hive.box(_authBoxName);

  String? get currentUserId => _authBox.get(_currentUserKey);

  bool get isSignedIn => currentUserId != null;

  Future<String> signInAnonymously() async {
    // Mevcut kullanıcı varsa onu döndür
    final existing = currentUserId;
    if (existing != null) return existing;

    // Yeni kullanıcı oluştur
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    await _authBox.put(_currentUserKey, userId);
    return userId;
  }

  Future<void> signOut() async {
    await _authBox.delete(_currentUserKey);
  }
}
