import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Kullanıcı profil modeli.
@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required String displayName,
    required int avatarId,
    required DateTime createdAt,
    DateTime? lastPlayedAt,
    @Default('tr') String locale,

    /// Tutorial tamamlandı mı?
    @Default(false) bool hasCompletedTutorial,

    /// Tutorial tamamlanma tarihi.
    DateTime? tutorialCompletedAt,
  }) = _UserProfile;

  /// Varsayılan yeni kullanıcı profili.
  factory UserProfile.newUser({
    required String id,
    String? displayName,
  }) =>
      UserProfile(
        id: id,
        displayName: displayName ?? 'Oyuncu',
        avatarId: 0,
        createdAt: DateTime.now(),
      );

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
