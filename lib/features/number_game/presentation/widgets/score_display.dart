import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Oyun sonucu ve puanı gösteren overlay widget.
class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({
    super.key,
    required this.targetNumber,
    required this.closestNumber,
    required this.distance,
    required this.baseScore,
    required this.timeBonus,
    required this.totalScore,
    required this.onPlayAgain,
    this.onContinue,
    this.isSolved = false,
  });

  final int targetNumber;
  final int? closestNumber;
  final int distance;
  final int baseScore;
  final int timeBonus;
  final int totalScore;
  final VoidCallback onPlayAgain;
  final VoidCallback? onContinue;
  final bool isSolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 360),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowDark,
                blurRadius: 40,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header section with answer
              _buildAnswerSection(),

              // Divider
              Container(
                height: 1,
                color: AppColors.borderLight,
              ),

              // Score breakdown
              _buildScoreSection(),

              // Actions
              _buildActionSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Result icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSolved
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSolved ? Icons.check_rounded : Icons.flag_rounded,
              color: isSolved ? AppColors.success : AppColors.primary,
              size: 32,
            ),
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            isSolved ? 'TAM İSABET!' : 'SÜRE DOLDU',
            style: AppTypography.headingLarge.copyWith(
              color: isSolved ? AppColors.success : AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 24),

          // Target and Found display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CompactStat(
                label: 'HEDEF',
                value: targetNumber.toString(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 1,
                height: 40,
                color: AppColors.borderLight,
              ),
              _CompactStat(
                label: 'BULUNAN',
                value: (closestNumber ?? 0).toString(),
                valueColor: isSolved ? AppColors.success : AppColors.textWhite,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 1,
                height: 40,
                color: AppColors.borderLight,
              ),
              _CompactStat(
                label: 'FARK',
                value: distance.toString(),
                valueColor: distance == 0 ? AppColors.success : AppColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.3),
      ),
      child: Column(
        children: [
          // Stats row
          StatRow(
            children: [
              StatCard(label: 'Puan', value: baseScore.toString()),
              StatCard(
                label: 'Süre Bonusu',
                value: timeBonus.toString(),
                prefix: '+',
                valueColor: AppColors.primary,
              ),
              StatCard(
                label: 'Toplam',
                value: totalScore.toString(),
                isHighlighted: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Continue or Play Again
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: onContinue != null ? 'DEVAM ET' : 'YENİ OYUN',
              icon: onContinue != null ? Icons.arrow_forward : Icons.refresh,
              onPressed: onContinue ?? onPlayAgain,
            ),
          ),

          if (onContinue != null) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: onPlayAgain,
              child: Text(
                'Tekrar Dene',
                style: AppTypography.buttonSmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Kompakt stat gösterimi.
class _CompactStat extends StatelessWidget {
  const _CompactStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.headingMedium.copyWith(
            color: valueColor ?? AppColors.textWhite,
          ),
        ),
      ],
    );
  }
}
