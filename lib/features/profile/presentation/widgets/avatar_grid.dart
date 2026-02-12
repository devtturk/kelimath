import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/domain.dart';

/// Avatar seçim grid'i.
class AvatarGrid extends StatelessWidget {
  const AvatarGrid({
    super.key,
    required this.selectedId,
    required this.onSelect,
  });

  final int selectedId;
  final void Function(int avatarId) onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: predefinedAvatars.length,
      itemBuilder: (context, index) {
        final avatar = predefinedAvatars[index];
        final isSelected = avatar.id == selectedId;

        return GestureDetector(
          onTap: () => onSelect(avatar.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                // Avatar container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: avatar.backgroundColor,
                    border: Border.all(
                      color: isSelected ? AppColors.accent : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color:
                                  avatar.backgroundColor.withValues(alpha: 0.5),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    avatar.icon,
                    size: 32,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // Avatar name
                Text(
                  avatar.name,
                  style: AppTypography.labelSmall.copyWith(
                    color: isSelected
                        ? AppColors.textWhite
                        : AppColors.textMuted,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Selected indicator
                if (isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppColors.accent,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
