import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// İstatistik kartı widget'ı.
/// Tur sonucu ekranında puan detayları için.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.isHighlighted = false,
    this.valueColor,
    this.prefix,
  });

  final String label;
  final String value;
  final bool isHighlighted;
  final Color? valueColor;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: isHighlighted
          ? BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              border: Border(
                top: BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            )
          : null,
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: isHighlighted
                ? AppTypography.primaryLabel
                : AppTypography.labelMedium,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (prefix != null)
                Text(
                  prefix!,
                  style: AppTypography.headingMedium.copyWith(
                    color: valueColor ?? AppColors.textWhite,
                  ),
                ),
              Text(
                value,
                style: isHighlighted
                    ? AppTypography.scoreDisplay.copyWith(
                        fontSize: 32,
                        color: valueColor ?? AppColors.primary,
                      )
                    : AppTypography.headingMedium.copyWith(
                        color: valueColor ?? AppColors.textWhite,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Yatay stat listesi için wrapper.
class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.3),
        border: Border(
          top: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              Expanded(child: children[i]),
              if (i < children.length - 1)
                VerticalDivider(
                  color: AppColors.borderLight,
                  width: 1,
                  thickness: 1,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
