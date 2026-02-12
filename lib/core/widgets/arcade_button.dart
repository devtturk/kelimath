import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Arcade tarzı 3D buton.
/// Sesli/Sessiz seçimi için kullanılır.
class ArcadeButton extends StatefulWidget {
  const ArcadeButton({
    super.key,
    required this.label,
    this.sublabel,
    this.onPressed,
    this.isEnabled = true,
    this.height = 80,
  });

  final String label;
  final String? sublabel;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double height;

  @override
  State<ArcadeButton> createState() => _ArcadeButtonState();
}

class _ArcadeButtonState extends State<ArcadeButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final shadowOffset = _isPressed ? 0.0 : 4.0;

    return GestureDetector(
      onTapDown: widget.isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: widget.isEnabled ? () => setState(() => _isPressed = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: widget.isEnabled ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryMuted,
              offset: Offset(0, shadowOffset),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label.toUpperCase(),
                style: AppTypography.buttonPrimary.copyWith(
                  fontSize: 18,
                  letterSpacing: 3,
                  color: widget.isEnabled
                      ? AppColors.textOnPrimary
                      : AppColors.textMuted,
                ),
              ),
              if (widget.sublabel != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    widget.sublabel!,
                    style: AppTypography.labelSmall.copyWith(
                      color: widget.isEnabled
                          ? AppColors.textOnPrimary.withValues(alpha: 0.7)
                          : AppColors.textMuted,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
