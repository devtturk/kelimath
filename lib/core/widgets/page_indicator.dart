import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Sayfa göstergesi (dot indicators).
/// Onboarding ve tutorial ekranlarında kullanılır.
class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
    this.activeColor,
    this.inactiveColor,
    this.size = 8,
    this.spacing = 8,
  });

  final int currentIndex;
  final int count;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return Container(
          width: size,
          height: size,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? (activeColor ?? AppColors.primary)
                : (inactiveColor ?? AppColors.textMuted.withValues(alpha: 0.3)),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: (activeColor ?? AppColors.primary).withValues(alpha: 0.6),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
