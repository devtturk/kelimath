import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

/// Tutorial highlight widget.
/// Hedef alanı vurgulayan animasyonlu widget.
/// Opsiyonel olarak talimat tooltip'i gösterebilir.
class TutorialHighlight extends StatefulWidget {
  const TutorialHighlight({
    super.key,
    required this.child,
    this.isActive = true,
    this.borderRadius = 12.0,
    this.padding = 4.0,
    this.instruction,
    this.showInstructionAbove = true,
    this.onTapInstruction,
  });

  /// İçerik widget'ı.
  final Widget child;

  /// Vurgulama aktif mi?
  final bool isActive;

  /// Border radius.
  final double borderRadius;

  /// İç padding.
  final double padding;

  /// Gösterilecek talimat (null ise gösterilmez).
  final String? instruction;

  /// Talimat üstte mi gösterilsin?
  final bool showInstructionAbove;

  /// Talimata tıklandığında (Tamam butonu için).
  final VoidCallback? onTapInstruction;

  @override
  State<TutorialHighlight> createState() => _TutorialHighlightState();
}

class _TutorialHighlightState extends State<TutorialHighlight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(TutorialHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) {
      return widget.child;
    }

    final highlightedChild = AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4 * _pulseAnimation.value),
                blurRadius: 20 * _pulseAnimation.value,
                spreadRadius: 2 * _pulseAnimation.value,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(widget.padding),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: widget.child,
          ),
        );
      },
    );

    // Talimat yoksa sadece highlight göster
    if (widget.instruction == null) {
      return highlightedChild;
    }

    // Talimat ile birlikte göster
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showInstructionAbove) ...[
          _buildInstructionBubble(),
          const SizedBox(height: 8),
        ],
        highlightedChild,
        if (!widget.showInstructionAbove) ...[
          const SizedBox(height: 8),
          _buildInstructionBubble(),
        ],
      ],
    );
  }

  Widget _buildInstructionBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              widget.instruction!,
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (widget.onTapInstruction != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: widget.onTapInstruction,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Tamam',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Global key ile widget'ın pozisyonunu bulan yardımcı sınıf.
class HighlightFinder {
  HighlightFinder._();

  /// GlobalKey ile widget'ın ekran üzerindeki Rect'ini bul.
  static Rect? findRect(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    return Rect.fromLTWH(
      position.dx,
      position.dy,
      size.width,
      size.height,
    );
  }
}
