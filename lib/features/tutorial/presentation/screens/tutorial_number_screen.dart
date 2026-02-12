import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../number_game/application/number_game_controller.dart';
import '../../../number_game/domain/game_step.dart';
import '../../../number_game/domain/operation.dart';
import '../../application/application.dart';
import '../../domain/domain.dart';

/// Sayı oyunu tutorial ekranı.
/// Gerçek NumberGameController kullanır, sadece üstüne tutorial ipuçları ekler.
class TutorialNumberScreen extends ConsumerStatefulWidget {
  const TutorialNumberScreen({super.key});

  @override
  ConsumerState<TutorialNumberScreen> createState() =>
      _TutorialNumberScreenState();
}

class _TutorialNumberScreenState extends ConsumerState<TutorialNumberScreen> {
  bool _isNavigating = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized && mounted) {
        _isInitialized = true;
        // Tutorial state'i başlat
        ref.read(tutorialControllerProvider.notifier).startNumberTutorial();
        // Gerçek oyunu sabit sayılarla başlat
        ref.read(numberGameControllerProvider.notifier).startGame(
          targetNumber: TutorialScenario.targetNumber,
          availableNumbers: TutorialScenario.numberValues,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(numberGameControllerProvider);
    final gameController = ref.read(numberGameControllerProvider.notifier);
    final tutorialState = ref.watch(tutorialControllerProvider);
    final tutorialController = ref.read(tutorialControllerProvider.notifier);

    // Tutorial tamamlandıysa bitiş ekranına git
    if (!_isNavigating &&
        (tutorialState.phase == TutorialPhase.completed ||
            tutorialState.isSkipped)) {
      _isNavigating = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _finishTutorial();
      });
      return const SizedBox.shrink();
    }

    final currentStep = tutorialState.currentStep;

    // Hedefe ulaşıldı mı kontrol et
    final reachedTarget = gameState.isSolved;

    // Free operation modunda hedefe ulaşıldıysa bir sonraki adıma geç
    if (currentStep?.action == TutorialAction.freeNumberOperation && reachedTarget) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          tutorialController.completeStep();
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorations
          _BackgroundDecorations(),

          // Main content
          Column(
            children: [
              // Header - Demo badge ile
              _buildDemoHeader(tutorialController),

              // Main game area
              Expanded(
                child: Column(
                  children: [
                    // Target display
                    _TargetCard(
                      targetNumber: gameState.targetNumber,
                      isSolved: gameState.isSolved,
                    ),

                    // Tutorial hint bubble (positioned near top)
                    if (currentStep != null &&
                        currentStep.action != TutorialAction.showInfo)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: _buildHintBubble(currentStep.instruction),
                      ),

                    // History (scrollable)
                    Expanded(
                      child: _HistorySection(
                        history: gameState.history,
                        closestNumber: gameState.closestToTarget.closestNumber,
                      ),
                    ),

                    // Control pad
                    _ControlPad(
                      availableNumbers: gameState.availableNumbers,
                      selectedNumberIndex: gameState.selectedNumberIndex,
                      selectedOperation: gameState.selectedOperation,
                      closestNumber: gameState.closestToTarget.closestNumber,
                      isWaitingForSecond: gameState.isReadyForSecondNumber,
                      canUndo: gameState.canUndo,
                      isPlaying: gameState.isPlaying,
                      onNumberTap: gameController.selectNumber,
                      onOperationTap: gameController.selectOperation,
                      onUndo: gameController.undo,
                      onReset: gameController.resetGame,
                      onSubmit: () {
                        // Tutorial submit adımını tamamla
                        if (currentStep?.action == TutorialAction.tapSubmitButton) {
                          tutorialController.completeStep();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Info modal overlay
          if (currentStep != null &&
              currentStep.action == TutorialAction.showInfo)
            _buildInfoModal(currentStep, tutorialController),
        ],
      ),
    );
  }

  Widget _buildDemoHeader(TutorialController controller) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Demo badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.school_outlined, size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'DEMO',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Title
            Text(
              'BİR İŞLEM',
              style: AppTypography.primaryLabel,
            ),

            const Spacer(),

            // Skip button
            TextButton(
              onPressed: controller.skipTutorial,
              child: Text(
                'Atla',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHintBubble(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowPrimary,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: Colors.white.withValues(alpha: 0.9),
            size: 20,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoModal(TutorialStep step, TutorialController controller) {
    return GestureDetector(
      onTap: controller.completeStep,
      child: Container(
        color: Colors.black.withValues(alpha: 0.75),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.glowPrimary,
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.calculate_outlined,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    step.instruction,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.85),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.glowPrimary,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Başla',
                          style: AppTypography.buttonPrimary.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward,
                            color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _finishTutorial() {
    Navigator.pushReplacementNamed(context, AppRoutes.tutorialComplete);
  }
}

/// Arka plan dekorasyonları.
class _BackgroundDecorations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.05),
            ),
          ),
        ),
        Positioned(
          bottom: -150,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withValues(alpha: 0.03),
            ),
          ),
        ),
      ],
    );
  }
}

/// Hedef sayı kartı.
class _TargetCard extends StatelessWidget {
  const _TargetCard({
    required this.targetNumber,
    required this.isSolved,
  });

  final int targetNumber;
  final bool isSolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surface, AppColors.surfaceLight],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'HEDEF',
            style: AppTypography.goldLabel,
          ),
          const SizedBox(height: 8),
          Text(
            targetNumber.toString(),
            style: AppTypography.targetNumber.copyWith(
              color: isSolved ? AppColors.success : AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}

/// İşlem geçmişi bölümü.
class _HistorySection extends StatelessWidget {
  const _HistorySection({
    required this.history,
    required this.closestNumber,
  });

  final List<GameStep> history;
  final int? closestNumber;

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(
        child: Text(
          'İşlemlere başla...',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final step = history[index];
        final isClosest = step.result == closestNumber;

        return _HistoryItem(
          stepNumber: index + 1,
          operation: '${step.firstNumber} ${step.operation.symbol} ${step.secondNumber}',
          result: step.result,
          isClosest: isClosest,
        );
      },
    );
  }
}

/// Geçmiş öğesi.
class _HistoryItem extends StatelessWidget {
  const _HistoryItem({
    required this.stepNumber,
    required this.operation,
    required this.result,
    required this.isClosest,
  });

  final int stepNumber;
  final String operation;
  final int result;
  final bool isClosest;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          // Step number badge
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.historyStepBadge,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '$stepNumber',
                style: AppTypography.historyStep,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Operation
          Expanded(
            child: Text(
              operation,
              style: AppTypography.historyOperation,
            ),
          ),

          // Equals sign
          Text(
            '=',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(width: 8),

          // Result
          Text(
            result.toString(),
            style: AppTypography.historyResult,
          ),

          if (isClosest) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 16,
            ),
          ],
        ],
      ),
    );
  }
}

/// Kontrol paneli (sayılar, operatörler, aksiyon butonları).
class _ControlPad extends StatelessWidget {
  const _ControlPad({
    required this.availableNumbers,
    required this.selectedNumberIndex,
    required this.selectedOperation,
    required this.closestNumber,
    required this.isWaitingForSecond,
    required this.canUndo,
    required this.isPlaying,
    required this.onNumberTap,
    required this.onOperationTap,
    required this.onUndo,
    required this.onReset,
    required this.onSubmit,
  });

  final List<int?> availableNumbers;
  final int? selectedNumberIndex;
  final Operation? selectedOperation;
  final int? closestNumber;
  final bool isWaitingForSecond;
  final bool canUndo;
  final bool isPlaying;
  final void Function(int index) onNumberTap;
  final void Function(Operation op) onOperationTap;
  final VoidCallback onUndo;
  final VoidCallback onReset;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        border: Border(
          top: BorderSide(color: AppColors.borderMedium),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 40,
            offset: Offset(0, -10),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        36, // Floating badge için üstte ekstra alan
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Number grid (3x2)
          _NumberGrid(
            numbers: availableNumbers,
            selectedIndex: selectedNumberIndex,
            closestNumber: closestNumber,
            onTap: isPlaying ? onNumberTap : (_) {},
          ),

          const SizedBox(height: 20),

          // Operation buttons
          _OperationRow(
            selectedOperation: selectedOperation,
            isEnabled: selectedNumberIndex != null && isPlaying,
            onTap: onOperationTap,
          ),

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              // Undo
              _ActionButton(
                icon: Icons.undo,
                label: 'GERİ',
                onTap: canUndo ? onUndo : null,
              ),

              const SizedBox(width: 16),

              // Submit
              Expanded(
                child: PrimaryButton(
                  label: 'GÖNDER',
                  icon: Icons.send,
                  onPressed: isPlaying ? onSubmit : null,
                  isEnabled: isPlaying,
                ),
              ),

              const SizedBox(width: 16),

              // Reset
              _ActionButton(
                icon: Icons.delete_outline,
                label: 'SIFIRLA',
                onTap: onReset,
                isDestructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Sayı grid'i (3x2).
class _NumberGrid extends StatelessWidget {
  const _NumberGrid({
    required this.numbers,
    required this.selectedIndex,
    required this.closestNumber,
    required this.onTap,
  });

  final List<int?> numbers;
  final int? selectedIndex;
  final int? closestNumber;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        final number = numbers[index];
        final isSelected = index == selectedIndex;
        final isClosest = number != null && number == closestNumber;

        return _NumberTile(
          number: number,
          isSelected: isSelected,
          isClosest: isClosest,
          isUsed: false,
          onTap: () => onTap(index),
        );
      },
    );
  }
}

/// Sayı taşı.
class _NumberTile extends StatefulWidget {
  const _NumberTile({
    required this.number,
    required this.isSelected,
    required this.isClosest,
    required this.isUsed,
    required this.onTap,
  });

  final int? number;
  final bool isSelected;
  final bool isClosest;
  final bool isUsed;
  final VoidCallback? onTap;

  @override
  State<_NumberTile> createState() => _NumberTileState();
}

class _NumberTileState extends State<_NumberTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.isClosest && !widget.isSelected) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_NumberTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClosest && !widget.isSelected) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isClosestActive = widget.isClosest && !widget.isSelected;

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ana tile
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isClosestActive ? _pulseAnimation.value : 1.0,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: AppTheme.durationFast,
              decoration: BoxDecoration(
                gradient: isClosestActive
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.success.withValues(alpha: 0.15),
                          AppColors.success.withValues(alpha: 0.05),
                        ],
                      )
                    : null,
                color: widget.isUsed
                    ? AppColors.surfaceLight.withValues(alpha: 0.3)
                    : isClosestActive
                        ? null
                        : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(
                  color: widget.isSelected
                      ? AppColors.primary
                      : isClosestActive
                          ? AppColors.success
                          : Colors.transparent,
                  width: widget.isSelected || isClosestActive ? 2.5 : 2,
                ),
                boxShadow: widget.isUsed
                    ? null
                    : [
                        if (widget.isSelected)
                          BoxShadow(
                            color: AppColors.glowPrimary,
                            blurRadius: 15,
                            spreadRadius: -3,
                          )
                        else if (isClosestActive)
                          BoxShadow(
                            color: AppColors.success.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: -2,
                          )
                        else
                          const BoxShadow(
                            color: AppColors.shadowDark,
                            blurRadius: 0,
                            offset: Offset(0, 4),
                          ),
                      ],
              ),
              child: Center(
                child: widget.isUsed
                    ? Text(
                        '-',
                        style: AppTypography.tileLarge.copyWith(
                          color: AppColors.textMuted.withValues(alpha: 0.3),
                        ),
                      )
                    : Text(
                        widget.number.toString(),
                        style: AppTypography.tileLarge.copyWith(
                          color: widget.isSelected
                              ? AppColors.primary
                              : isClosestActive
                                  ? AppColors.success
                                  : AppColors.textWhite,
                          fontWeight: isClosestActive
                              ? FontWeight.w800
                              : FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),

          // Floating "EN YAKIN" badge - tile'ın üstünde
          if (isClosestActive)
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.success,
                        AppColors.success.withValues(alpha: 0.85),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'EN YAKIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// İşlem butonları satırı.
class _OperationRow extends StatelessWidget {
  const _OperationRow({
    required this.selectedOperation,
    required this.isEnabled,
    required this.onTap,
  });

  final Operation? selectedOperation;
  final bool isEnabled;
  final void Function(Operation) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Operation.values.map((op) {
        final isSelected = op == selectedOperation;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _OperationButton(
              operation: op,
              isSelected: isSelected,
              isEnabled: isEnabled,
              onTap: () => onTap(op),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// İşlem butonu.
class _OperationButton extends StatelessWidget {
  const _OperationButton({
    required this.operation,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final Operation operation;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: AppTheme.durationFast,
        height: 52,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderMedium,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.glowPrimary,
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            operation.symbol,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.textOnPrimary
                  : isEnabled
                      ? AppColors.textWhite
                      : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

/// Aksiyon butonu (Undo, Reset).
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = onTap == null
        ? AppColors.textMuted
        : isDestructive
            ? AppColors.error
            : AppColors.textMuted;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDestructive && onTap != null
                  ? AppColors.error.withValues(alpha: 0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
