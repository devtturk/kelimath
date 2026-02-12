import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'circular_timer.dart';

/// Oyun ekranları için header widget'ı.
/// Puan ve timer içerir.
class GameHeader extends StatelessWidget {
  const GameHeader({
    super.key,
    required this.score,
    required this.timeRemaining,
    this.title,
    this.totalTime = 60,
    this.onBack,
  });

  final int score;
  final int timeRemaining;
  final String? title;
  final int totalTime;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Left: Timer
            CircularTimer(
              timeRemaining: timeRemaining,
              totalTime: totalTime,
            ),

            const Spacer(),

            // Center: Title and Score
            Column(
              children: [
                if (title != null)
                  Text(
                    title!.toUpperCase(),
                    style: AppTypography.primaryLabel,
                  ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      score.toString(),
                      style: AppTypography.headingLarge.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'PUAN',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Right: Back button or spacer
            if (onBack != null)
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.borderLight.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              )
            else
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
