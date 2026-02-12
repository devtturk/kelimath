import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// Spotlight overlay - hedef alanı aydınlatır, geri kalanı karartır.
/// Kullanıcının dikkatini doğrudan hedef elemente çeker.
class TutorialSpotlight extends StatelessWidget {
  const TutorialSpotlight({
    super.key,
    required this.targetRect,
    required this.instruction,
    this.onTapAnywhere,
    this.showHandPointer = true,
    this.instructionPosition = InstructionPosition.auto,
    this.padding = 8.0,
    this.borderRadius = 12.0,
  });

  /// Aydınlatılacak hedef alanın rect'i.
  final Rect targetRect;

  /// Gösterilecek talimat metni.
  final String instruction;

  /// Ekranda herhangi bir yere tıklandığında (overlay dışında).
  final VoidCallback? onTapAnywhere;

  /// Parmak işaretçisi gösterilsin mi?
  final bool showHandPointer;

  /// Talimat pozisyonu.
  final InstructionPosition instructionPosition;

  /// Spotlight padding.
  final double padding;

  /// Spotlight border radius.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final paddedRect = targetRect.inflate(padding);

    // Talimat pozisyonunu hesapla
    final showAbove = _shouldShowAbove(screenSize);

    return Stack(
      children: [
        // Karartılmış overlay (hedef alan hariç)
        Positioned.fill(
          child: CustomPaint(
            painter: _SpotlightPainter(
              targetRect: paddedRect,
              borderRadius: borderRadius,
              overlayColor: Colors.black.withValues(alpha: 0.75),
            ),
          ),
        ),

        // Spotlight glow efekti
        Positioned(
          left: paddedRect.left - 4,
          top: paddedRect.top - 4,
          child: Container(
            width: paddedRect.width + 8,
            height: paddedRect.height + 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius + 4),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.6),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        ),

        // Talimat balonu
        Positioned(
          left: 24,
          right: 24,
          top: showAbove ? null : paddedRect.bottom + 20,
          bottom: showAbove ? screenSize.height - paddedRect.top + 20 : null,
          child: _buildInstructionBubble(showAbove),
        ),

        // Parmak işaretçisi
        if (showHandPointer)
          Positioned(
            left: paddedRect.center.dx - 24,
            top: paddedRect.center.dy - 24,
            child: const _AnimatedHandPointer(),
          ),
      ],
    );
  }

  bool _shouldShowAbove(Size screenSize) {
    if (instructionPosition == InstructionPosition.above) return true;
    if (instructionPosition == InstructionPosition.below) return false;

    // Auto: ekranın alt yarısındaysa üstte göster
    return targetRect.center.dy > screenSize.height * 0.5;
  }

  Widget _buildInstructionBubble(bool arrowBelow) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ok işareti (üstte)
          if (!arrowBelow)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CustomPaint(
                size: const Size(20, 10),
                painter: _ArrowPainter(pointUp: true),
              ),
            ),

          Text(
            instruction,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          // Ok işareti (altta)
          if (arrowBelow)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CustomPaint(
                size: const Size(20, 10),
                painter: _ArrowPainter(pointUp: false),
              ),
            ),
        ],
      ),
    );
  }
}

/// Spotlight için instruction pozisyonu.
enum InstructionPosition {
  auto,
  above,
  below,
}

/// Spotlight painter - hedef alan dışını karartır.
class _SpotlightPainter extends CustomPainter {
  _SpotlightPainter({
    required this.targetRect,
    required this.borderRadius,
    required this.overlayColor,
  });

  final Rect targetRect;
  final double borderRadius;
  final Color overlayColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = overlayColor;

    // Tüm ekranı kapsayan path
    final fullPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Hedef alanı (rounded rect)
    final targetPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(targetRect, Radius.circular(borderRadius)),
      );

    // Farkı çiz (hedef alan boş kalır)
    final combinedPath = Path.combine(PathOperation.difference, fullPath, targetPath);
    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.targetRect != targetRect ||
        oldDelegate.overlayColor != overlayColor;
  }
}

/// Ok işareti painter.
class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.pointUp});

  final bool pointUp;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final path = Path();
    if (pointUp) {
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
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.pointUp != pointUp;
  }
}

/// Animasyonlu parmak işaretçisi.
class _AnimatedHandPointer extends StatefulWidget {
  const _AnimatedHandPointer();

  @override
  State<_AnimatedHandPointer> createState() => _AnimatedHandPointerState();
}

class _AnimatedHandPointerState extends State<_AnimatedHandPointer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.touch_app,
                size: 28,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
