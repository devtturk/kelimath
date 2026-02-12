import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Tur göstergesi widget'ı.
/// "Tur 1/6" veya "1/3" şeklinde gösterim.
class RoundIndicator extends StatelessWidget {
  const RoundIndicator({
    super.key,
    required this.current,
    required this.total,
    this.showIcon = true,
    this.compact = false,
  });

  final int current;
  final int total;
  final bool showIcon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surfaceHighlight,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Icon(
                Icons.flag,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              '$current/$total',
              style: AppTypography.roundIndicator,
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Icon(
            Icons.flag,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          'Tur ',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          '$current',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '/$total',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
