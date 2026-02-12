import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// Tutorial tooltip widget.
/// Açıklama balonu gösterir.
class TutorialTooltip extends StatelessWidget {
  const TutorialTooltip({
    super.key,
    required this.instruction,
    this.showNextButton = false,
    this.onNext,
    this.arrowOnTop = true,
  });

  /// Gösterilecek talimat.
  final String instruction;

  /// "Devam" butonu gösterilsin mi?
  final bool showNextButton;

  /// "Devam" butonuna tıklandığında.
  final VoidCallback? onNext;

  /// Ok işareti üstte mi?
  final bool arrowOnTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Üst ok
        if (arrowOnTop) _buildArrow(isUp: true),

        // Ana içerik
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Talimat metni
              Text(
                instruction,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),

              // Devam butonu
              if (showNextButton) ...[
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: onNext,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Devam',
                          style: AppTypography.buttonSecondary.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Alt ok
        if (!arrowOnTop) _buildArrow(isUp: false),
      ],
    );
  }

  /// Ok işareti.
  Widget _buildArrow({required bool isUp}) {
    return Center(
      child: CustomPaint(
        size: const Size(20, 10),
        painter: _ArrowPainter(
          isUp: isUp,
          color: AppColors.surface,
          borderColor: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

/// Ok çizen painter.
class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.isUp,
    required this.color,
    required this.borderColor,
  });

  final bool isUp;
  final Color color;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    if (isUp) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }

    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.isUp != isUp ||
        oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor;
  }
}
