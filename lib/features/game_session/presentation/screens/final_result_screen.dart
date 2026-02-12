import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Oyun sonu sonuç ekranı.
/// 6 turun tamamlanmasının ardından gösterilir.
class FinalResultScreen extends StatelessWidget {
  const FinalResultScreen({
    super.key,
    required this.totalScore,
    required this.roundScores,
    this.totalTime,
    this.onPlayAgain,
    this.onHome,
  });

  final int totalScore;
  final List<RoundScore> roundScores;
  final Duration? totalTime;
  final VoidCallback? onPlayAgain;
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorations
          _BackgroundDecorations(),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Score display
                _buildScoreSection(),

                // Round breakdown
                Expanded(
                  child: _buildRoundsSection(),
                ),

                // Actions
                _buildActions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Trophy icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.gold,
                  AppColors.goldDark,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 40,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'OYUN BİTTİ!',
            style: AppTypography.headingLarge.copyWith(
              color: AppColors.textWhite,
            ),
          ),

          if (totalTime != null) ...[
            const SizedBox(height: 8),
            Text(
              'Toplam Süre: ${_formatDuration(totalTime!)}',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'TOPLAM PUAN',
            style: AppTypography.goldLabel,
          ),
          const SizedBox(height: 8),
          Text(
            totalScore.toString(),
            style: AppTypography.scoreDisplay.copyWith(
              fontSize: 64,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundsSection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TUR DETAYLARI',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.separated(
              itemCount: roundScores.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final round = roundScores[index];
                return _RoundRow(
                  roundNumber: index + 1,
                  isWordGame: round.isWordGame,
                  score: round.score,
                  timeBonus: round.timeBonus,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          // Home button
          Expanded(
            child: _SecondaryButton(
              label: 'ANA MENÜ',
              icon: Icons.home,
              onTap: () {
                if (onHome != null) {
                  onHome!();
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
          ),

          const SizedBox(width: 16),

          // Play again button
          Expanded(
            flex: 2,
            child: PrimaryButton(
              label: 'YENİDEN OYNA',
              icon: Icons.refresh,
              onPressed: () {
                if (onPlayAgain != null) {
                  onPlayAgain!();
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes dk $seconds sn';
  }
}

/// Tur puanı modeli.
class RoundScore {
  const RoundScore({
    required this.isWordGame,
    required this.score,
    required this.timeBonus,
  });

  final bool isWordGame;
  final int score;
  final int timeBonus;

  int get total => score + timeBonus;
}

/// Tur satırı widget'ı.
class _RoundRow extends StatelessWidget {
  const _RoundRow({
    required this.roundNumber,
    required this.isWordGame,
    required this.score,
    required this.timeBonus,
  });

  final int roundNumber;
  final bool isWordGame;
  final int score;
  final int timeBonus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          // Round number
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isWordGame
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$roundNumber',
                style: AppTypography.bodyMedium.copyWith(
                  color: isWordGame ? AppColors.primary : AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Game type
          Expanded(
            child: Row(
              children: [
                Icon(
                  isWordGame ? Icons.abc : Icons.calculate,
                  color: AppColors.textMuted,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  isWordGame ? 'Kelime' : 'İşlem',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Score
          Text(
            '${score + timeBonus}',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// İkincil buton.
class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppColors.borderMedium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textMuted, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.buttonSecondary.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Arka plan dekorasyonları.
class _BackgroundDecorations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withValues(alpha: 0.05),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.05),
            ),
          ),
        ),
      ],
    );
  }
}
