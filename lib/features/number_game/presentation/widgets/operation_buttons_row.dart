import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/operation.dart';

/// Dört işlem butonlarını gösteren widget.
class OperationButtonsRow extends StatelessWidget {
  const OperationButtonsRow({
    super.key,
    required this.onOperationTap,
    this.selectedOperation,
    this.isEnabled = true,
  });

  /// İşlem seçildiğinde çağrılacak callback.
  final void Function(Operation operation) onOperationTap;

  /// Şu an seçili olan işlem.
  final Operation? selectedOperation;

  /// Butonlar aktif mi? (Sayı seçili değilse false)
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final operation in Operation.values) ...[
          _OperationButton(
            operation: operation,
            isSelected: selectedOperation == operation,
            isEnabled: isEnabled,
            onTap: () => onOperationTap(operation),
          ),
          if (operation != Operation.values.last) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _OperationButton extends StatelessWidget {
  const _OperationButton({
    required this.operation,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final Operation operation;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppColors.primaryDark, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            operation.symbol,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _textColor,
            ),
          ),
        ),
      ),
    );
  }

  Color get _backgroundColor {
    if (!isEnabled) {
      return AppColors.operationButtonDisabled;
    }
    if (isSelected) {
      return AppColors.operationButtonSelected;
    }
    return AppColors.operationButton;
  }

  Color get _textColor {
    if (!isEnabled) {
      return AppColors.textSecondary;
    }
    if (isSelected) {
      return AppColors.textOnPrimary;
    }
    return AppColors.operationButtonText;
  }
}
