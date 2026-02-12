import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';
import 'achievement_badge.dart';

/// Yatay başarımlar listesi.
class AchievementsRow extends StatelessWidget {
  const AchievementsRow({
    super.key,
    required this.achievements,
    this.onViewAll,
  });

  final List<Achievement> achievements;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    // Önce kilidi açılmış, sonra ilerleme olanları göster
    final sorted = List<Achievement>.from(achievements)
      ..sort((a, b) {
        if (a.isUnlocked && !b.isUnlocked) return -1;
        if (!a.isUnlocked && b.isUnlocked) return 1;
        return b.progressPercent.compareTo(a.progressPercent);
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BAŞARIMLAR',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              if (onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    'Tümünü Gör',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Scrollable badges
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sorted.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return AchievementBadge(
                achievement: sorted[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
