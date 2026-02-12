import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Oyun kontrol butonlarını (Undo, Reset) gösteren widget.
class GameControlsBar extends StatelessWidget {
  const GameControlsBar({
    super.key,
    required this.onUndo,
    required this.onReset,
    this.canUndo = false,
  });

  /// Geri al butonu callback'i.
  final VoidCallback onUndo;

  /// Sıfırla butonu callback'i.
  final VoidCallback onReset;

  /// Geri alma yapılabilir mi?
  final bool canUndo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ControlButton(
            label: 'GERİ AL',
            icon: Icons.undo_rounded,
            color: AppColors.undoButton,
            onTap: canUndo ? onUndo : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ControlButton(
            label: 'SIFIRLA',
            icon: Icons.refresh_rounded,
            color: AppColors.resetButton,
            onTap: onReset,
          ),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  bool get _isEnabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: _isEnabled ? color : color.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.textOnPrimary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _isEnabled
                    ? AppColors.textOnPrimary
                    : AppColors.textOnPrimary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
