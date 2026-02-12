import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Ana buton widget'ı.
/// GÖNDER, ANLADIM gibi primary action butonları için.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.size = ButtonSize.large,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isEnabled;
  final ButtonSize size;

  @override
  Widget build(BuildContext context) {
    final height = size.height;
    final textStyle = size == ButtonSize.small
        ? AppTypography.buttonSecondary
        : AppTypography.buttonPrimary;

    return AnimatedContainer(
      duration: AppTheme.durationFast,
      height: height,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.glowPrimary,
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled && !isLoading ? onPressed : null,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textOnPrimary,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: textStyle.copyWith(
                          color: isEnabled
                              ? AppColors.textOnPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(
                          icon,
                          color: isEnabled
                              ? AppColors.textOnPrimary
                              : AppColors.textMuted,
                          size: size == ButtonSize.small ? 18 : 22,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

enum ButtonSize {
  small,
  medium,
  large,
}

extension ButtonSizeExtension on ButtonSize {
  double get height => switch (this) {
        ButtonSize.small => 40,
        ButtonSize.medium => 48,
        ButtonSize.large => 56,
      };
}
