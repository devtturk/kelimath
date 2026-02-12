import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Geri sayım timer'ını gösteren widget.
class TimerDisplay extends StatelessWidget {
  const TimerDisplay({
    super.key,
    required this.timeRemaining,
    this.isWarning = false,
  });

  /// Kalan süre (saniye).
  final int timeRemaining;

  /// Süre azaldığında uyarı rengi göster.
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final minutes = timeRemaining ~/ 60;
    final seconds = timeRemaining % 60;
    final timeText = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    // 10 saniyeden az kaldığında uyarı
    final showWarning = isWarning || timeRemaining <= 10;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: showWarning ? AppColors.error : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 20,
            color: showWarning ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(
            timeText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: showWarning ? AppColors.textOnPrimary : AppColors.textPrimary,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
