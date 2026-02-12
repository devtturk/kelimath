import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../application/application.dart';

/// Tutorial tamamlandı ekranı.
class TutorialCompleteScreen extends ConsumerWidget {
  const TutorialCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth > 500 ? 400.0 : screenWidth - 64;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Başarı ikonu
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.success,
                        AppColors.success.withValues(alpha: 0.8),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withValues(alpha: 0.4),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                // Başlık
                Text(
                  'Demo Tamamlandı!',
                  style: AppTypography.headingLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Açıklama
                SizedBox(
                  width: maxWidth,
                  child: Text(
                    'Artık oyunun temellerini öğrendin.\nGerçek oyunda harfler ve sayılar rastgele gelecek.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // Özellikler listesi
                SizedBox(
                  width: maxWidth,
                  child: Column(
                    children: [
                      _buildFeatureRow(
                        icon: Icons.timer_outlined,
                        text: 'Her turda 60 saniye süren var',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureRow(
                        icon: Icons.star_outline,
                        text: 'Uzun kelimeler daha çok puan kazandırır',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureRow(
                        icon: Icons.calculate_outlined,
                        text: 'Hedefe yakın sonuçlar puan kazandırır',
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                // Başla butonu
                SizedBox(
                  width: maxWidth,
                  child: GestureDetector(
                    onTap: () => _startGame(context, ref),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.85),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Oyuna Başla',
                            style: AppTypography.buttonPrimary.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Ana menü butonu
                TextButton(
                  onPressed: () => _goHome(context, ref),
                  child: Text(
                    'Ana Menüye Dön',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  void _startGame(BuildContext context, WidgetRef ref) {
    // Tutorial'ı tamamlandı olarak işaretle
    ref.read(tutorialControllerProvider.notifier).finishTutorial();

    // Oyuna başla
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.letterSelection,
      (route) => route.isFirst,
      arguments: const LetterSelectionArgs(
        roundNumber: 1,
        totalRounds: 4,
      ),
    );
  }

  void _goHome(BuildContext context, WidgetRef ref) {
    // Tutorial'ı tamamlandı olarak işaretle
    ref.read(tutorialControllerProvider.notifier).finishTutorial();

    // Ana menüye dön
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }
}
