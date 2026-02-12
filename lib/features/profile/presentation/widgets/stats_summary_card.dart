import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

/// Özet istatistikler kartı.
class StatsSummaryCard extends StatelessWidget {
  const StatsSummaryCard({
    super.key,
    required this.stats,
  });

  final GameStatistics stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.surfaceLight,
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.sports_esports,
            value: stats.totalGamesPlayed.toString(),
            label: 'Oyun',
          ),
          _Divider(),
          _StatItem(
            icon: Icons.stars,
            value: _formatScore(stats.totalScore),
            label: 'Puan',
          ),
          _Divider(),
          _StatItem(
            icon: Icons.emoji_events,
            value: _formatScore(stats.highScore),
            label: 'Rekor',
            highlight: true,
          ),
          _Divider(),
          _StatItem(
            icon: Icons.trending_up,
            value: stats.averageScore.toStringAsFixed(0),
            label: 'Ort.',
          ),
        ],
      ),
    );
  }

  String _formatScore(int score) {
    if (score >= 1000000) {
      return '${(score / 1000000).toStringAsFixed(1)}M';
    } else if (score >= 1000) {
      return '${(score / 1000).toStringAsFixed(1)}K';
    }
    return score.toString();
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final color = highlight ? AppColors.accent : AppColors.textSecondary;

    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTypography.headingMedium.copyWith(
            color: highlight ? AppColors.accent : AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: AppColors.borderLight,
    );
  }
}
