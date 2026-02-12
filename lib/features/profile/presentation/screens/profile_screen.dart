import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/router/app_router.dart';
import '../../application/application.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

/// Profil ekranı.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final statsAsync = ref.watch(statisticsProvider);
    final achievementsAsync = ref.watch(achievementsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Profil yüklenemedi',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => ref.invalidate(userProfileProvider),
                  child: Text(
                    'Tekrar Dene',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          data: (profile) {
            if (profile == null) {
              return _buildNoProfile(context, ref);
            }

            return CustomScrollView(
              slivers: [
                // Header with back button
                SliverToBoxAdapter(
                  child: _buildAppBar(context),
                ),

                // Profile header
                SliverToBoxAdapter(
                  child: ProfileHeader(
                    profile: profile,
                    onAvatarTap: () => _navigateToAvatarSelection(context),
                    onNameTap: () => _showNameEditDialog(context, ref, profile),
                  ),
                ),

                // Stats summary
                SliverToBoxAdapter(
                  child: statsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (stats) => StatsSummaryCard(stats: stats),
                  ),
                ),

                // Streak display
                SliverToBoxAdapter(
                  child: statsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (stats) => StreakDisplay(
                      currentStreak: stats.currentStreak,
                      longestStreak: stats.longestStreak,
                    ),
                  ),
                ),

                // Achievements
                SliverToBoxAdapter(
                  child: achievementsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (achievements) => AchievementsRow(
                      achievements: achievements,
                    ),
                  ),
                ),

                // Game stats tabs
                SliverToBoxAdapter(
                  child: statsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (stats) => GameStatsTabs(
                      wordStats: stats.wordStats,
                      numberStats: stats.numberStats,
                    ),
                  ),
                ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.textWhite,
              ),
            ),
          ),

          const Spacer(),

          Text(
            'PROFİL',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textWhite,
            ),
          ),

          const Spacer(),

          // Placeholder for symmetry
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildNoProfile(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'Giriş yapılmadı',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Profilini görmek için giriş yap',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await ref.read(userProfileProvider.notifier).signInAnonymously();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
            ),
            child: Text(
              'Anonim Giriş Yap',
              style: AppTypography.buttonPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAvatarSelection(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.avatarSelection);
  }

  void _showNameEditDialog(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
  ) {
    final controller = TextEditingController(text: profile.displayName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        ),
        title: Text(
          'İsim Değiştir',
          style: AppTypography.headingMedium.copyWith(
            color: AppColors.textWhite,
          ),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.textWhite),
          decoration: InputDecoration(
            hintText: 'Kullanıcı adı',
            hintStyle: TextStyle(color: AppColors.textMuted),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İPTAL',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                ref.read(userProfileProvider.notifier).updateDisplayName(
                      newName,
                    );
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'KAYDET',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
