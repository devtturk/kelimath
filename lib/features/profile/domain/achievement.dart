import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

/// Başarım türleri.
enum AchievementType {
  firstWin,       // İlk oyununu tamamla
  tenGames,       // 10 oyun tamamla
  fiftyGames,     // 50 oyun tamamla
  hundredGames,   // 100 oyun tamamla
  perfectWord,    // 9 harfli tam kelime bul
  perfectNumber,  // Hedefe tam ulaş
  streakThree,    // 3 gün üst üste oyna
  streakSeven,    // 7 gün üst üste oyna
  streakThirty,   // 30 gün üst üste oyna
  wordMaster,     // 100 kelime bul
  numberMaster,   // 50 hedefe tam ulaş
  speedDemon,     // 30 saniyeden az sürede tamamla
}

/// Başarım modeli.
@freezed
abstract class Achievement with _$Achievement {
  const Achievement._();

  const factory Achievement({
    required AchievementType type,
    required String titleTr,
    required String descriptionTr,
    required String iconName,
    required int requiredValue,
    required bool isUnlocked,
    DateTime? unlockedAt,
    @Default(0) int currentProgress,
  }) = _Achievement;

  /// İlerleme yüzdesi.
  double get progressPercent =>
      requiredValue > 0 ? (currentProgress / requiredValue).clamp(0.0, 1.0) : 0;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

/// Varsayılan başarım listesi.
List<Achievement> getDefaultAchievements() => [
      const Achievement(
        type: AchievementType.firstWin,
        titleTr: 'İlk Zafer',
        descriptionTr: 'İlk oyununu tamamla',
        iconName: 'emoji_events',
        requiredValue: 1,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.tenGames,
        titleTr: 'Çaylak',
        descriptionTr: '10 oyun tamamla',
        iconName: 'looks_one',
        requiredValue: 10,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.fiftyGames,
        titleTr: 'Deneyimli',
        descriptionTr: '50 oyun tamamla',
        iconName: 'military_tech',
        requiredValue: 50,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.hundredGames,
        titleTr: 'Usta',
        descriptionTr: '100 oyun tamamla',
        iconName: 'workspace_premium',
        requiredValue: 100,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.perfectWord,
        titleTr: 'Kelime Ustası',
        descriptionTr: '9 harfli tam kelime bul',
        iconName: 'menu_book',
        requiredValue: 1,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.perfectNumber,
        titleTr: 'İşlem Dehası',
        descriptionTr: 'Hedefe tam ulaş',
        iconName: 'calculate',
        requiredValue: 1,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.streakThree,
        titleTr: 'Üç Gün',
        descriptionTr: '3 gün üst üste oyna',
        iconName: 'local_fire_department',
        requiredValue: 3,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.streakSeven,
        titleTr: 'Bir Hafta',
        descriptionTr: '7 gün üst üste oyna',
        iconName: 'whatshot',
        requiredValue: 7,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.streakThirty,
        titleTr: 'Bir Ay',
        descriptionTr: '30 gün üst üste oyna',
        iconName: 'local_fire_department',
        requiredValue: 30,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.wordMaster,
        titleTr: 'Sözlük',
        descriptionTr: '100 kelime bul',
        iconName: 'auto_stories',
        requiredValue: 100,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.numberMaster,
        titleTr: 'Hesap Makinesi',
        descriptionTr: '50 hedefe tam ulaş',
        iconName: 'functions',
        requiredValue: 50,
        isUnlocked: false,
      ),
      const Achievement(
        type: AchievementType.speedDemon,
        titleTr: 'Hızlı Parmak',
        descriptionTr: '30 saniyeden az sürede tamamla',
        iconName: 'bolt',
        requiredValue: 1,
        isUnlocked: false,
      ),
    ];
