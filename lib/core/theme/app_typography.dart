import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Uygulama tipografi sistemi.
/// Font family: Manrope (display), Epilogue (headings/target numbers)
abstract final class AppTypography {
  // === FONT FAMILIES ===
  static const String fontFamilyDisplay = 'Manrope';
  static const String fontFamilyHeading = 'Epilogue';

  // === HEADING STYLES ===

  /// Sayfa basligi - buyuk (24pt, bold)
  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  /// Sayfa basligi - orta (20pt, semibold)
  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  /// Kart basligi (18pt, bold)
  static const TextStyle headingSmall = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  // === DISPLAY STYLES (Large numbers, targets) ===

  /// Hedef sayi - cok buyuk (56pt, extra bold)
  static const TextStyle targetNumber = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 56,
    fontWeight: FontWeight.w900,
    color: AppColors.textWhite,
    letterSpacing: 2,
  );

  /// Buyuk puan gosterimi (48pt, extra bold)
  static const TextStyle scoreDisplay = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    letterSpacing: 1,
  );

  /// Timer (28pt, bold, mono-space effect)
  static const TextStyle timer = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: 2,
  );

  /// Timer kucuk (18pt)
  static const TextStyle timerSmall = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: 1,
  );

  // === BODY TEXT STYLES ===

  /// Normal govde metni (16pt)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Orta govde metni (14pt)
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  /// Kucuk govde metni (12pt)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // === LABEL STYLES ===

  /// Buyuk etiket - ustbilgi (14pt, bold, uppercase)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  );

  /// Orta etiket (12pt, semibold, uppercase)
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 1.2,
  );

  /// Kucuk etiket (10pt, bold, uppercase)
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
  );

  // === BUTTON STYLES ===

  /// Birincil buton metni (16pt, extra bold)
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnPrimary,
    letterSpacing: 1.5,
  );

  /// Ikincil buton metni (14pt, bold)
  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 1,
  );

  /// Kucuk buton/link metni (12pt, bold)
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 0.5,
  );

  // === TILE STYLES ===

  /// Harf/Sayi tile - buyuk (28pt, extra bold)
  static const TextStyle tileLarge = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.tileText,
  );

  /// Harf/Sayi tile - orta (22pt, bold)
  static const TextStyle tileMedium = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.tileText,
  );

  /// Harf/Sayi tile - kucuk (18pt, semibold)
  static const TextStyle tileSmall = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.tileText,
  );

  /// Tile kullanilmis durumu
  static const TextStyle tileUsed = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.tileUsedText,
  );

  // === KEYBOARD STYLES ===

  /// Klavye tusu (18pt, medium)
  static const TextStyle keyboardKey = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.keyText,
  );

  // === SPECIAL STYLES ===

  /// Altin etiket (xs, bold, uppercase)
  static const TextStyle goldLabel = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
    letterSpacing: 2,
  );

  /// Primary etiket (xs, bold, uppercase)
  static const TextStyle primaryLabel = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 2,
  );

  /// Hata mesaji (12pt, medium)
  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  /// Basari mesaji (12pt, medium)
  static const TextStyle successText = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
  );

  // === HISTORY PANEL ===

  /// Gecmis adim numarasi
  static const TextStyle historyStep = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  /// Gecmis islem metni
  static const TextStyle historyOperation = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  /// Gecmis sonuc
  static const TextStyle historyResult = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  // === ROUND/TURN INDICATOR ===

  /// Tur gostergesi (12pt, bold)
  static const TextStyle roundIndicator = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );

  // === HELPER METHODS ===

  /// Renk degistirme
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Font boyutu degistirme
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Font agirligi degistirme
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
}
