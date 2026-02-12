import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Oyun taşı durumu.
enum TileState {
  /// Normal, kullanılabilir
  normal,

  /// Seçili
  selected,

  /// Kullanılmış (dimmed)
  used,

  /// Boş slot
  empty,

  /// Joker taşı
  joker,
}

/// Harf ve sayı taşları için ortak widget.
/// Kelime ve İşlem oyunlarında kullanılır.
class GameTile extends StatelessWidget {
  const GameTile({
    super.key,
    required this.content,
    this.state = TileState.normal,
    this.size = TileSize.medium,
    this.onTap,
    this.showPulse = false,
  });

  /// Taşın içeriği (harf veya sayı)
  final String content;

  /// Taşın durumu
  final TileState state;

  /// Taş boyutu
  final TileSize size;

  /// Tıklama callback
  final VoidCallback? onTap;

  /// Pulse animasyonu gösterilsin mi
  final bool showPulse;

  @override
  Widget build(BuildContext context) {
    final dimensions = size.dimensions;
    final isInteractive = state == TileState.normal || state == TileState.selected;

    return GestureDetector(
      onTap: isInteractive ? onTap : null,
      child: AnimatedContainer(
        duration: AppTheme.durationFast,
        width: dimensions.width,
        height: dimensions.height,
        decoration: _getDecoration(),
        child: Center(
          child: _buildContent(),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (state) {
      case TileState.normal:
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surfaceLight,
              AppColors.surface,
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppColors.borderMedium),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowDark,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        );

      case TileState.selected:
        return BoxDecoration(
          color: AppColors.tileBackground,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.glowPrimary,
              blurRadius: 15,
              spreadRadius: -3,
            ),
          ],
        );

      case TileState.used:
        return BoxDecoration(
          color: AppColors.tileUsed.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: Colors.transparent),
        );

      case TileState.empty:
        return BoxDecoration(
          color: AppColors.slotEmpty,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: AppColors.slotBorder,
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        );

      case TileState.joker:
        return BoxDecoration(
          color: AppColors.jokerBackground,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppColors.jokerBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColors.glowPrimary,
              blurRadius: 15,
              spreadRadius: -3,
            ),
          ],
        );
    }
  }

  Widget _buildContent() {
    if (state == TileState.empty) {
      return showPulse
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            )
          : const SizedBox.shrink();
    }

    if (state == TileState.joker) {
      return Icon(
        Icons.help_outline,
        color: AppColors.jokerText,
        size: size.iconSize,
      );
    }

    final textStyle = _getTextStyle();

    if (state == TileState.used) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Text(content, style: textStyle),
          // Çizgi efekti
          Transform.rotate(
            angle: 0.785398, // 45 derece
            child: Container(
              width: size.dimensions.width * 0.5,
              height: 1,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
          ),
        ],
      );
    }

    return Text(content, style: textStyle);
  }

  TextStyle _getTextStyle() {
    final baseStyle = switch (size) {
      TileSize.small => AppTypography.tileSmall,
      TileSize.medium => AppTypography.tileMedium,
      TileSize.large => AppTypography.tileLarge,
    };

    return switch (state) {
      TileState.normal => baseStyle,
      TileState.selected => baseStyle.copyWith(color: AppColors.primary),
      TileState.used => baseStyle.copyWith(color: AppColors.tileUsedText),
      TileState.empty => baseStyle,
      TileState.joker => baseStyle.copyWith(color: AppColors.jokerText),
    };
  }
}

/// Taş boyutu.
enum TileSize {
  small,
  medium,
  large,
}

extension TileSizeExtension on TileSize {
  Size get dimensions => switch (this) {
        TileSize.small => const Size(40, 48),
        TileSize.medium => const Size(52, 60),
        TileSize.large => const Size(72, 80),
      };

  double get iconSize => switch (this) {
        TileSize.small => 18,
        TileSize.medium => 24,
        TileSize.large => 32,
      };
}
