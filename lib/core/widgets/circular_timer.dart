import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Dairesel zamanlayıcı widget'ı.
/// Oyun ekranlarında süre gösterimi için.
class CircularTimer extends StatelessWidget {
  const CircularTimer({
    super.key,
    required this.timeRemaining,
    this.totalTime = 60,
    this.size = 48,
    this.strokeWidth = 3,
    this.warningThreshold = 10,
  });

  /// Kalan süre (saniye)
  final int timeRemaining;

  /// Toplam süre (saniye)
  final int totalTime;

  /// Widget boyutu
  final double size;

  /// Çizgi kalınlığı
  final double strokeWidth;

  /// Uyarı eşiği (saniye)
  final int warningThreshold;

  @override
  Widget build(BuildContext context) {
    final progress = timeRemaining / totalTime;
    final isWarning = timeRemaining <= warningThreshold;
    final color = isWarning ? AppColors.timerWarning : AppColors.timerNormal;

  String formatTime(int seconds) {
    if (seconds > 60) {
      final minutes = seconds ~/ 60;
      final secs = seconds % 60;
      return '$minutes:${secs.toString().padLeft(2, '0')}';
    }
    return seconds.toString();
  }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CustomPaint(
            size: Size(size, size),
            painter: _CircleProgressPainter(
              progress: 1.0,
              color: AppColors.timerBackground,
              strokeWidth: strokeWidth,
            ),
          ),
          // Progress circle
          CustomPaint(
            size: Size(size, size),
            painter: _CircleProgressPainter(
              progress: progress,
              color: color,
              strokeWidth: strokeWidth,
              hasGlow: true,
            ),
          ),
          // Timer text (format: M:SS for > 60s, just seconds for <= 60s)
          Text(
            formatTime(timeRemaining),
            style: AppTypography.timerSmall.copyWith(
              color: isWarning ? AppColors.timerWarning : AppColors.textWhite,
              fontSize: timeRemaining > 60 ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  _CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    this.hasGlow = false,
  });

  final double progress;
  final Color color;
  final double strokeWidth;
  final bool hasGlow;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (hasGlow) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.3)
        ..strokeWidth = strokeWidth + 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        glowPaint,
      );
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
