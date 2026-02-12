import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

/// Kelime ve sayı oyunu istatistik sekmeleri.
class GameStatsTabs extends StatefulWidget {
  const GameStatsTabs({
    super.key,
    required this.wordStats,
    required this.numberStats,
  });

  final WordGameStats wordStats;
  final NumberGameStats numberStats;

  @override
  State<GameStatsTabs> createState() => _GameStatsTabsState();
}

class _GameStatsTabsState extends State<GameStatsTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusXl),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textMuted,
              labelStyle: AppTypography.labelMedium,
              tabs: const [
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: 'KELİME',
                ),
                Tab(
                  icon: Icon(Icons.calculate),
                  text: 'İŞLEM',
                ),
              ],
            ),
          ),

          // Tab content
          SizedBox(
            height: 200,
            child: TabBarView(
              controller: _tabController,
              children: [
                _WordStatsContent(stats: widget.wordStats),
                _NumberStatsContent(stats: widget.numberStats),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WordStatsContent extends StatelessWidget {
  const _WordStatsContent({required this.stats});

  final WordGameStats stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.sports_esports,
                  value: stats.gamesPlayed.toString(),
                  label: 'Oyun',
                ),
              ),
              Expanded(
                child: _StatTile(
                  icon: Icons.emoji_events,
                  value: stats.highScore.toString(),
                  label: 'Rekor',
                  highlight: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.spellcheck,
                  value: stats.totalWordsFound.toString(),
                  label: 'Kelime',
                ),
              ),
              Expanded(
                child: _StatTile(
                  icon: Icons.text_fields,
                  value: stats.longestWord.toString(),
                  label: 'En Uzun',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (stats.bestWord.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'En İyi: ${stats.bestWord}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NumberStatsContent extends StatelessWidget {
  const _NumberStatsContent({required this.stats});

  final NumberGameStats stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.sports_esports,
                  value: stats.gamesPlayed.toString(),
                  label: 'Oyun',
                ),
              ),
              Expanded(
                child: _StatTile(
                  icon: Icons.emoji_events,
                  value: stats.highScore.toString(),
                  label: 'Rekor',
                  highlight: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.check_circle,
                  value: stats.exactMatchCount.toString(),
                  label: 'Tam İsabet',
                ),
              ),
              Expanded(
                child: _StatTile(
                  icon: Icons.route,
                  value: stats.fewestSteps > 0
                      ? stats.fewestSteps.toString()
                      : '-',
                  label: 'En Az Adım',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Başarı oranı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.percent,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Başarı: ${(stats.exactMatchRate * 100).toStringAsFixed(0)}%',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
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
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: highlight ? AppColors.accent : AppColors.textMuted,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTypography.headingSmall.copyWith(
                  color: highlight ? AppColors.accent : AppColors.textWhite,
                ),
              ),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
