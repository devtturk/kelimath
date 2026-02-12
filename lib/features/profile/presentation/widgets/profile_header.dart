import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

/// Profil başlık widget'ı.
/// Avatar, isim ve üyelik bilgisi gösterir.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    this.onAvatarTap,
    this.onNameTap,
  });

  final UserProfile profile;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNameTap;

  @override
  Widget build(BuildContext context) {
    final avatar = getAvatarById(profile.avatarId);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar
          GestureDetector(
            onTap: onAvatarTap,
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: avatar.backgroundColor,
                    border: Border.all(
                      color: AppColors.accent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: avatar.backgroundColor.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    avatar.icon,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                // Edit badge
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.background,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // İsim
          GestureDetector(
            onTap: onNameTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.displayName,
                  style: AppTypography.headingLarge.copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.edit,
                  size: 18,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Üyelik tarihi
          Text(
            _formatMemberSince(profile.createdAt),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  String _formatMemberSince(DateTime date) {
    final months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return '${months[date.month - 1]} ${date.year}\'den beri üye';
  }
}
