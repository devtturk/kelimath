import 'package:flutter/material.dart';

/// Uygulama renk paleti - Dark theme based design system.
abstract final class AppColors {
  // === PRIMARY COLORS ===
  /// Ana vurgu rengi - Teal/Cyan (#00c2b2)
  static const Color primary = Color(0xFF00C2B2);
  static const Color primaryLight = Color(0xFF00D4C3);
  static const Color primaryDark = Color(0xFF009E91);
  static const Color primaryMuted = Color(0xFF008F83);

  // === BACKGROUND COLORS ===
  /// Ana arka plan - Charcoal/Void (#121212)
  static const Color background = Color(0xFF121212);
  static const Color backgroundAlt = Color(0xFF0F2322);

  /// Yüzey renkleri - Surface variants
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceLight = Color(0xFF2C2C2C);
  static const Color surfaceLighter = Color(0xFF3A3A3A);
  static const Color surfaceDark = Color(0xFF162E2C);
  static const Color surfaceHighlight = Color(0xFF1F3B39);

  // === TEXT COLORS ===
  static const Color textPrimary = Color(0xFFE0E0E0);
  static const Color textSecondary = Color(0xFFA1A8B0);
  // textMuted: WCAG AA için minimum 4.5:1 kontrast (koyu arkaplan üzerinde)
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFF0F2322);
  static const Color textWhite = Color(0xFFFFFFFF);

  // === ACCENT COLORS ===
  /// Altın rengi - Gold accent (#D4AF37)
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE5C158);
  static const Color goldDark = Color(0xFFB8962E);

  /// Vurgu rengi (accent) - gold ile aynı
  static const Color accent = gold;

  // === GAME SPECIFIC COLORS ===

  // Number/Letter Tiles
  static const Color tileBackground = Color(0xFF2C2C2C);
  static const Color tileBackgroundActive = Color(0xFF3A4A49);
  static const Color tileBorder = Color(0xFF333333);
  static const Color tileText = Color(0xFFFFFFFF);
  static const Color tileUsed = Color(0xFF1A1A1A);
  static const Color tileUsedText = Color(0xFF666666);

  // Empty Slots
  static const Color slotEmpty = Color(0xFF181818);
  static const Color slotBorder = Color(0xFF333333);

  // Selected State
  static const Color selected = primary;
  static const Color selectedGlow = Color(0x4D00C2B2); // 30% opacity

  // Operation Buttons
  static const Color operationButton = surface;
  static const Color operationButtonActive = primary;
  static const Color operationButtonText = textPrimary;

  // Target Display
  static const Color targetBackground = surface;
  static const Color targetText = textWhite;
  static const Color targetLabel = gold;

  // Timer
  static const Color timerNormal = primary;
  static const Color timerWarning = Color(0xFFEF4444);
  static const Color timerBackground = Color(0xFF2A2A2A);

  // Action Buttons
  static const Color submitButton = primary;
  static const Color undoButton = Color(0xFF3A3A3A);
  static const Color resetButton = Color(0xFFEF4444);
  static const Color deleteButton = Color(0xFFEF4444);

  // === STATUS COLORS ===
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = primary;

  // === HISTORY PANEL ===
  static const Color historyBackground = Color(0xFF1A1A1A);
  static const Color historyItem = Color(0xFF252525);
  static const Color historyBorder = Color(0xFF333333);
  static const Color historyText = textSecondary;
  static const Color historyStepBadge = Color(0xFF1A3332);

  // === KEYBOARD COLORS ===
  static const Color keyboardBackground = Color(0xFF0B1A19);
  static const Color keyBackground = Color(0xFF3A4A49);
  static const Color keyBackgroundSpecial = Color(0xFF2A3A39);
  static const Color keyText = textWhite;
  static const Color keyShadow = Color(0x66000000);

  // === JOKER ===
  static const Color jokerBackground = Color(0x1A00C2B2); // 10% primary
  static const Color jokerBorder = Color(0x6600C2B2); // 40% primary
  static const Color jokerText = primary;

  // === BORDER & DIVIDER ===
  static const Color border = Color(0xFF333333);
  static const Color borderLight = Color(0x0DFFFFFF); // 5% white
  static const Color borderMedium = Color(0x1AFFFFFF); // 10% white
  static const Color divider = Color(0xFF2A2A2A);

  // === SHADOWS & GLOW ===
  static const Color shadowDark = Color(0x80000000);
  static const Color glowPrimary = Color(0x4D00C2B2);

  // === GRADIENTS ===
  static const List<Color> primaryGradient = [primaryLight, primary];
  static const List<Color> surfaceGradient = [surfaceLight, surface];
  static const List<Color> darkGradient = [Color(0xFF1E1E1E), Color(0xFF121212)];

  // === LEGACY COLORS (for backward compatibility) ===
  @Deprecated('Use tileBackground instead')
  static const Color numberButton = tileBackground;
  @Deprecated('Use selected instead')
  static const Color numberButtonSelected = selected;
  @Deprecated('Use tileText instead')
  static const Color numberButtonText = tileText;
  @Deprecated('Use operationButton instead')
  static const Color operationButtonSelected = operationButtonActive;
  @Deprecated('Use tileBorder instead')
  static const Color operationButtonDisabled = tileBorder;
  @Deprecated('Use operationButtonText instead')
  static const Color operationButtonTextOld = operationButtonText;
}
