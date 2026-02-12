import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';
import 'tutorial_tooltip.dart';

/// Tutorial overlay widget.
/// Ekranı karartır ve hedef alanı vurgular.
class TutorialOverlay extends StatelessWidget {
  const TutorialOverlay({
    super.key,
    required this.step,
    required this.progress,
    this.highlightRect,
    this.onTapHighlight,
    this.onTapNext,
    this.onSkip,
  });

  /// Mevcut adım.
  final TutorialStep step;

  /// İlerleme (0.0 - 1.0).
  final double progress;

  /// Vurgulanacak alan (null ise sadece tooltip gösterilir).
  final Rect? highlightRect;

  /// Vurgulanan alana tıklandığında.
  final VoidCallback? onTapHighlight;

  /// "Devam" butonuna tıklandığında (showInfo adımları için).
  final VoidCallback? onTapNext;

  /// "Atla" butonuna tıklandığında.
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Karartma katmanı - tıklamaları ENGELLEME (IgnorePointer)
        IgnorePointer(
          child: _buildDarkOverlay(context),
        ),

        // İlerleme çubuğu (üstte)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          child: IgnorePointer(
            child: _buildProgressBar(),
          ),
        ),

        // Atla butonu (sağ üstte) - bu tıklanabilir kalmalı
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: _buildSkipButton(),
        ),

        // Tooltip - tıklanabilir kalmalı (showInfo için)
        _buildTooltip(context),
      ],
    );
  }

  /// Karartma katmanı ve highlight deliği.
  Widget _buildDarkOverlay(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Karartma alanına tıklanırsa bir şey yapma
      },
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: _OverlayPainter(
          highlightRect: highlightRect,
          overlayColor: Colors.black.withValues(alpha: 0.75),
        ),
      ),
    );
  }

  /// İlerleme çubuğu.
  Widget _buildProgressBar() {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  /// Atla butonu.
  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: onSkip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Atla',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.skip_next,
              size: 16,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  /// Tooltip widget'ı.
  Widget _buildTooltip(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width > 500;

    // Tooltip pozisyonunu hesapla
    double top;
    bool arrowOnTop;

    if (highlightRect != null) {
      // Highlight'ın üstünde veya altında göster
      if (step.tooltipPosition == TooltipPosition.top) {
        top = highlightRect!.top - 100;
        arrowOnTop = false;
      } else {
        top = highlightRect!.bottom + 12;
        arrowOnTop = true;
      }
    } else {
      // Ekranın ortasında göster
      top = screenSize.height * 0.35;
      arrowOnTop = false;
    }

    // Sınırları kontrol et
    top = top.clamp(
      MediaQuery.of(context).padding.top + 50,
      screenSize.height - 180,
    );

    // Web için ortala ve maksimum genişlik sınırla
    final tooltipWidth = isWide ? 400.0 : screenSize.width - 32;
    final horizontalPadding = (screenSize.width - tooltipWidth) / 2;

    return Positioned(
      top: top,
      left: horizontalPadding.clamp(16.0, double.infinity),
      right: horizontalPadding.clamp(16.0, double.infinity),
      child: TutorialTooltip(
        instruction: step.instruction,
        showNextButton: step.action == TutorialAction.showInfo,
        onNext: onTapNext,
        arrowOnTop: arrowOnTop,
      ),
    );
  }
}

/// Overlay painter - karartma ve highlight deliği çizer.
class _OverlayPainter extends CustomPainter {
  _OverlayPainter({
    required this.highlightRect,
    required this.overlayColor,
  });

  final Rect? highlightRect;
  final Color overlayColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = overlayColor;

    // Tüm ekranı karart
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);

    if (highlightRect != null) {
      // Highlight deliği için path oluştur
      final path = Path()
        ..addRect(fullRect)
        ..addRRect(
          RRect.fromRectAndRadius(
            highlightRect!.inflate(8),
            const Radius.circular(12),
          ),
        )
        ..fillType = PathFillType.evenOdd;

      canvas.drawPath(path, paint);

      // Highlight border (glow efekti)
      final glowPaint = Paint()
        ..color = AppColors.primary.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          highlightRect!.inflate(8),
          const Radius.circular(12),
        ),
        glowPaint,
      );
    } else {
      // Highlight yok, sadece karart
      canvas.drawRect(fullRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter oldDelegate) {
    return oldDelegate.highlightRect != highlightRect ||
        oldDelegate.overlayColor != overlayColor;
  }
}
