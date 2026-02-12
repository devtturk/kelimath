import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

/// Mevcut harflerin gösterildiği raf.
/// Kullanılan harfler soluk gösterilir.
class LetterRack extends StatelessWidget {
  const LetterRack({
    super.key,
    required this.letters,
    this.usedLetters = const [],
    this.hasJoker = true,
    this.jokerUsed = false,
    this.onLetterTap,
    this.onJokerTap,
  });

  final List<String> letters;
  final List<int> usedLetters;
  final bool hasJoker;
  final bool jokerUsed;
  final void Function(String letter)? onLetterTap;
  final VoidCallback? onJokerTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Letter tiles
          ...List.generate(letters.length, (index) {
            final isUsed = usedLetters.contains(index);
            return _LetterTile(
              letter: letters[index],
              isUsed: isUsed,
              onTap: isUsed ? null : () => onLetterTap?.call(letters[index]),
            );
          }),

          // Joker tile
          if (hasJoker)
            _JokerTile(
              isUsed: jokerUsed,
              onTap: jokerUsed ? null : onJokerTap,
            ),
        ],
      ),
    );
  }
}

/// Harf taşı.
class _LetterTile extends StatelessWidget {
  const _LetterTile({
    required this.letter,
    this.isUsed = false,
    this.onTap,
  });

  final String letter;
  final bool isUsed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppTheme.durationFast,
        width: 36,
        height: 44,
        decoration: BoxDecoration(
          gradient: isUsed
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.surfaceHighlight,
                    AppColors.surfaceDark,
                  ],
                ),
          color: isUsed ? AppColors.surfaceHighlight.withValues(alpha: 0.4) : null,
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(
            color: isUsed ? Colors.transparent : AppColors.borderMedium,
          ),
          boxShadow: isUsed
              ? null
              : const [
                  BoxShadow(
                    color: AppColors.shadowDark,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            letter,
            style: AppTypography.tileSmall.copyWith(
              color: isUsed ? AppColors.tileUsedText : AppColors.textWhite,
            ),
          ),
        ),
      ),
    );
  }
}

/// Joker taşı.
class _JokerTile extends StatelessWidget {
  const _JokerTile({
    this.isUsed = false,
    this.onTap,
  });

  final bool isUsed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppTheme.durationFast,
        width: 36,
        height: 44,
        decoration: BoxDecoration(
          gradient: isUsed
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.jokerBackground,
                    AppColors.surfaceDark,
                  ],
                ),
          color: isUsed ? AppColors.surfaceHighlight.withValues(alpha: 0.4) : null,
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(
            color: isUsed ? Colors.transparent : AppColors.jokerBorder,
          ),
          boxShadow: isUsed
              ? null
              : [
                  BoxShadow(
                    color: AppColors.glowPrimary,
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.help_outline,
              color: isUsed ? AppColors.tileUsedText : AppColors.primary,
              size: 20,
            ),
            if (!isUsed)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
