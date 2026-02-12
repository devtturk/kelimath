import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Sayı oyununda kullanılan tek bir sayı butonu.
class NumberButton extends StatelessWidget {
  const NumberButton({
    super.key,
    required this.number,
    required this.onTap,
    this.isSelected = false,
    this.isWaitingForSecond = false,
  });

  /// Gösterilecek sayı.
  final int number;

  /// Tıklama callback'i.
  final VoidCallback onTap;

  /// Sayı seçili mi?
  final bool isSelected;

  /// İkinci sayı bekleniyor mu? (İlk sayı ve operatör seçili)
  final bool isWaitingForSecond;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: AppColors.primaryDark, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.numberButtonText,
            ),
          ),
        ),
      ),
    );
  }

  Color get _backgroundColor {
    if (isSelected) {
      return AppColors.numberButtonSelected;
    }
    if (isWaitingForSecond) {
      return AppColors.primaryLight;
    }
    return AppColors.numberButton;
  }
}
