import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// Günlük seri gösterimi.
class StreakDisplay extends StatelessWidget {
  const StreakDisplay({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
  });

  final int currentStreak;
  final int longestStreak;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: currentStreak > 0
              ? [
                  const Color(0xFFEF4444).withValues(alpha: 0.2),
                  const Color(0xFFF97316).withValues(alpha: 0.1),
                ]
              : [
                  AppColors.surface,
                  AppColors.surfaceLight,
                ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(
          color: currentStreak > 0
              ? const Color(0xFFEF4444).withValues(alpha: 0.3)
              : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          // Alev ikonu
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentStreak > 0
                  ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                  : AppColors.surface,
            ),
            child: Icon(
              Icons.local_fire_department,
              size: 32,
              color: currentStreak > 0
                  ? const Color(0xFFEF4444)
                  : AppColors.textMuted,
            ),
          ),

          const SizedBox(width: 16),

          // Seri bilgisi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      currentStreak.toString(),
                      style: AppTypography.scoreDisplay.copyWith(
                        color: currentStreak > 0
                            ? const Color(0xFFEF4444)
                            : AppColors.textMuted,
                        fontSize: 36,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'GÜN SERİ',
                      style: AppTypography.labelMedium.copyWith(
                        color: currentStreak > 0
                            ? const Color(0xFFEF4444)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  currentStreak > 0
                      ? 'Harika gidiyorsun!'
                      : 'Yeni bir seri başlat!',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // En uzun seri
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'EN UZUN',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.whatshot,
                    size: 18,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$longestStreak gün',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
