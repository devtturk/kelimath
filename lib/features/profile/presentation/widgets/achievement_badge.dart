import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

/// Başarım rozeti widget'ı.
class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.achievement,
    this.size = 60,
    this.onTap,
  });

  final Achievement achievement;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _showDetails(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Badge
          Stack(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: achievement.isUnlocked
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                        )
                      : null,
                  color: achievement.isUnlocked ? null : AppColors.surface,
                  border: Border.all(
                    color: achievement.isUnlocked
                        ? AppColors.accent
                        : AppColors.borderLight,
                    width: 2,
                    style: achievement.isUnlocked
                        ? BorderStyle.solid
                        : BorderStyle.none,
                  ),
                  boxShadow: achievement.isUnlocked
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  _getIcon(achievement.iconName),
                  size: size * 0.45,
                  color: achievement.isUnlocked
                      ? Colors.white
                      : AppColors.textMuted.withValues(alpha: 0.5),
                ),
              ),
              // Progress ring
              if (!achievement.isUnlocked && achievement.currentProgress > 0)
                SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    value: achievement.progressPercent,
                    strokeWidth: 3,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              // Lock icon
              if (!achievement.isUnlocked && achievement.currentProgress == 0)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Icon(
                      Icons.lock,
                      size: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Title
          SizedBox(
            width: size + 20,
            child: Text(
              achievement.titleTr,
              style: AppTypography.labelSmall.copyWith(
                color: achievement.isUnlocked
                    ? AppColors.textWhite
                    : AppColors.textMuted,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'emoji_events':
        return Icons.emoji_events;
      case 'looks_one':
        return Icons.looks_one;
      case 'military_tech':
        return Icons.military_tech;
      case 'workspace_premium':
        return Icons.workspace_premium;
      case 'menu_book':
        return Icons.menu_book;
      case 'calculate':
        return Icons.calculate;
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'whatshot':
        return Icons.whatshot;
      case 'auto_stories':
        return Icons.auto_stories;
      case 'functions':
        return Icons.functions;
      case 'bolt':
        return Icons.bolt;
      default:
        return Icons.star;
    }
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        ),
        title: Row(
          children: [
            Icon(
              _getIcon(achievement.iconName),
              color: achievement.isUnlocked
                  ? AppColors.accent
                  : AppColors.textMuted,
            ),
            const SizedBox(width: 12),
            Text(
              achievement.titleTr,
              style: AppTypography.headingMedium.copyWith(
                color: AppColors.textWhite,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievement.descriptionTr,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            if (!achievement.isUnlocked) ...[
              Text(
                'İlerleme: ${achievement.currentProgress}/${achievement.requiredValue}',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: achievement.progressPercent,
                backgroundColor: AppColors.borderLight,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ] else ...[
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tamamlandı!',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'TAMAM',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
