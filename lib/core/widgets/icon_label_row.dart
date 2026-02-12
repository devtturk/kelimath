import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// İkon ve etiket içeren satır widget'ı.
/// Tutorial ekranlarındaki madde listesi için.
class IconLabelRow extends StatelessWidget {
  const IconLabelRow({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.iconBackgroundColor,
    this.labelStyle,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBackgroundColor ?? AppColors.surfaceLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: labelStyle ?? AppTypography.bodyLarge,
          ),
        ),
      ],
    );
  }
}
