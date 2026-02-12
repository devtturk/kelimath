import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Hedef sayıyı gösteren widget.
class TargetDisplay extends StatelessWidget {
  const TargetDisplay({
    super.key,
    required this.targetNumber,
    this.isSolved = false,
  });

  /// Hedef sayı.
  final int targetNumber;

  /// Hedefe ulaşıldı mı?
  final bool isSolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: isSolved ? AppColors.success : AppColors.targetBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'HEDEF',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.targetText.withValues(alpha: 0.7),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            targetNumber.toString(),
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: AppColors.targetText,
            ),
          ),
          if (isSolved) ...[
            const SizedBox(height: 8),
            const Text(
              'TEBRIKLER!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.targetText,
                letterSpacing: 2,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
