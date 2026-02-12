import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

/// Kelime giriş gösterimi.
/// Yazılan harfleri slot'lar halinde gösterir.
class WordInputDisplay extends StatelessWidget {
  const WordInputDisplay({
    super.key,
    required this.guess,
    this.jokerUsed = false,
    this.jokerLetter,
    this.invalidIndices = const [],
    this.maxLength = 9,
  });

  final String guess;
  final bool jokerUsed;
  final String? jokerLetter;
  final List<int> invalidIndices;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(maxLength, (index) {
          if (index < guess.length) {
            final letter = guess[index];
            final isInvalid = invalidIndices.contains(index);
            final isJoker = jokerUsed && jokerLetter == letter && index == guess.indexOf(jokerLetter!);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _FilledSlot(
                letter: letter,
                isInvalid: isInvalid,
                isJoker: isJoker,
              ),
            );
          } else if (index == guess.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _CursorSlot(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _EmptySlot(),
            );
          }
        }),
      ),
    );
  }
}

/// Dolu slot (harf içeren).
class _FilledSlot extends StatelessWidget {
  const _FilledSlot({
    required this.letter,
    this.isInvalid = false,
    this.isJoker = false,
  });

  final String letter;
  final bool isInvalid;
  final bool isJoker;

  @override
  Widget build(BuildContext context) {
    final borderColor = isInvalid
        ? AppColors.error
        : isJoker
            ? AppColors.primary
            : AppColors.primary;

    final backgroundColor = isInvalid
        ? AppColors.error.withValues(alpha: 0.1)
        : isJoker
            ? AppColors.jokerBackground
            : AppColors.surfaceDark;

    return AnimatedContainer(
      duration: AppTheme.durationFast,
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMd)),
        border: Border(
          bottom: BorderSide(color: borderColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: AppTypography.tileLarge.copyWith(
            color: isInvalid
                ? AppColors.error
                : isJoker
                    ? AppColors.primary
                    : AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}

/// Cursor slot (sonraki harf için).
class _CursorSlot extends StatefulWidget {
  @override
  State<_CursorSlot> createState() => _CursorSlotState();
}

class _CursorSlotState extends State<_CursorSlot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMd)),
        border: Border(
          bottom: BorderSide(color: AppColors.textMuted, width: 4),
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _controller.value,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.textMuted,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Boş slot.
class _EmptySlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withValues(alpha: 0.3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMd)),
        border: Border(
          bottom: BorderSide(color: AppColors.surfaceLighter, width: 4),
        ),
      ),
    );
  }
}
