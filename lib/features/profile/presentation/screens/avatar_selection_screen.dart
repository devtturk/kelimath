import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../application/application.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

/// Avatar seçim ekranı.
class AvatarSelectionScreen extends ConsumerStatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  ConsumerState<AvatarSelectionScreen> createState() =>
      _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState
    extends ConsumerState<AvatarSelectionScreen> {
  int? _selectedAvatarId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Mevcut avatar ID'sini al
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profile = ref.read(userProfileProvider).value;
      if (profile != null) {
        setState(() {
          _selectedAvatarId = profile.avatarId;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);
    final currentAvatarId = profileAsync.value?.avatarId ?? 0;
    final selectedId = _selectedAvatarId ?? currentAvatarId;
    final hasChanged = selectedId != currentAvatarId;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            _buildAppBar(context),

            // Selected avatar preview
            Padding(
              padding: const EdgeInsets.all(24),
              child: _buildPreview(selectedId),
            ),

            // Avatar grid
            Expanded(
              child: SingleChildScrollView(
                child: AvatarGrid(
                  selectedId: selectedId,
                  onSelect: (id) {
                    setState(() {
                      _selectedAvatarId = id;
                    });
                  },
                ),
              ),
            ),

            // Save button
            if (hasChanged)
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : () => _saveAvatar(selectedId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusFull),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'KAYDET',
                            style: AppTypography.buttonPrimary,
                          ),
                  ),
                ),
              ),
          ],
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
            'AVATAR SEÇ',
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

  Widget _buildPreview(int avatarId) {
    final avatar = getAvatarById(avatarId);

    return Column(
      children: [
        // Large avatar preview
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: avatar.backgroundColor,
            border: Border.all(
              color: AppColors.accent,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: avatar.backgroundColor.withValues(alpha: 0.5),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Icon(
            avatar.icon,
            size: 60,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          avatar.name,
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textWhite,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Avatarını seç',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Future<void> _saveAvatar(int avatarId) async {
    setState(() {
      _isSaving = true;
    });

    try {
      await ref.read(userProfileProvider.notifier).updateAvatar(avatarId);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Avatar kaydedilemedi: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
