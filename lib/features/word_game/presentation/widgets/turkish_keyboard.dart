import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

/// Türkçe klavye widget'ı.
/// Oyun ekranlarında kullanılır.
class TurkishKeyboard extends StatelessWidget {
  const TurkishKeyboard({
    super.key,
    required this.onKeyTap,
    required this.onBackspace,
    this.onClear,
    this.enabled = true,
  });

  final void Function(String key) onKeyTap;
  final VoidCallback onBackspace;
  final VoidCallback? onClear;
  final bool enabled;

  static const _row1 = ['E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'Ğ', 'Ü'];
  static const _row2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ş', 'İ'];
  static const _row3 = ['Z', 'C', 'V', 'B', 'N', 'M', 'Ö', 'Ç'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.keyboardBackground,
      padding: EdgeInsets.only(
        left: 4,
        right: 4,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1
          _buildRow(_row1),
          const SizedBox(height: 8),

          // Row 2
          _buildRow(_row2, sidePadding: 12),
          const SizedBox(height: 8),

          // Row 3 with special keys
          _buildRow3(),
          const SizedBox(height: 8),

          // Bottom row
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys, {double sidePadding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((key) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: _KeyButton(
              label: key,
              onTap: enabled ? () => onKeyTap(key) : null,
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildRow3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Shift (decorative)
          _SpecialKeyButton(
            icon: Icons.keyboard_capslock,
            onTap: null, // Not functional
          ),
          const SizedBox(width: 4),

          // Letter keys
          ..._row3.map((key) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _KeyButton(
                label: key,
                onTap: enabled ? () => onKeyTap(key) : null,
              ),
            ),
          )),

          const SizedBox(width: 4),

          // Backspace
          _SpecialKeyButton(
            icon: Icons.backspace_outlined,
            onTap: enabled ? onBackspace : null,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // 123 (decorative)
          _SpecialKeyButton(
            label: '123',
            width: 48,
            onTap: null,
          ),

          const SizedBox(width: 4),

          // Globe (decorative)
          _SpecialKeyButton(
            icon: Icons.language,
            width: 48,
            onTap: null,
          ),

          const SizedBox(width: 4),

          // Space (decorative, not functional in this game)
          Expanded(
            flex: 2,
            child: _KeyButton(
              label: 'Boşluk',
              onTap: null, // Space not used in word game
              isSpecial: true,
            ),
          ),

          const SizedBox(width: 4),

          // Clear
          SizedBox(
            width: 80,
            child: _KeyButton(
              label: 'Temizle',
              onTap: enabled ? onClear : null,
              isSpecial: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// Normal klavye tuşu.
class _KeyButton extends StatelessWidget {
  const _KeyButton({
    required this.label,
    this.onTap,
    this.isSpecial = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isSpecial;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isSpecial ? AppColors.keyBackgroundSpecial : AppColors.keyBackground,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: AppColors.keyShadow,
              blurRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: isSpecial
                ? AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  )
                : AppTypography.keyboardKey,
          ),
        ),
      ),
    );
  }
}

/// Özel tuş (ikon içeren).
class _SpecialKeyButton extends StatelessWidget {
  const _SpecialKeyButton({
    this.icon,
    this.label,
    this.onTap,
    this.width = 44,
  });

  final IconData? icon;
  final String? label;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.keyBackgroundSpecial,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: AppColors.keyShadow,
              blurRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: AppColors.textMuted, size: 20)
              : Text(
                  label ?? '',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
