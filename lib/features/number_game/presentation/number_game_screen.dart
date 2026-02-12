import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../../../core/router/app_router.dart';
import '../application/number_game_controller.dart';
import '../domain/number_game_state.dart';
import '../domain/game_step.dart';
import '../domain/operation.dart';
import '../domain/solver/backtracking_solver.dart';
import 'widgets/widgets.dart';

/// Sayı oyunu ana ekranı.
class NumberGameScreen extends ConsumerStatefulWidget {
  const NumberGameScreen({
    super.key,
    this.roundNumber = 1,
    this.totalRounds = 4,
    this.onGameComplete,
  });

  final int roundNumber;
  final int totalRounds;
  final void Function(int score, int timeBonus)? onGameComplete;

  @override
  ConsumerState<NumberGameScreen> createState() => _NumberGameScreenState();
}

class _NumberGameScreenState extends ConsumerState<NumberGameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(numberGameControllerProvider.notifier).startRandomGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(numberGameControllerProvider);
    final controller = ref.read(numberGameControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorations
          _BackgroundDecorations(),

          // Main content
          Column(
            children: [
              // Header
              _buildHeader(state),

              // Main game area
              Expanded(
                child: Column(
                  children: [
                    // Target display
                    _TargetCard(
                      targetNumber: state.targetNumber,
                      isSolved: state.isSolved,
                    ),

                    // History (scrollable)
                    Expanded(
                      child: _HistorySection(
                        history: state.history,
                        closestNumber: state.closestToTarget.closestNumber,
                      ),
                    ),

                    // Control pad
                    _ControlPad(
                      availableNumbers: state.availableNumbers,
                      selectedNumberIndex: state.selectedNumberIndex,
                      selectedOperation: state.selectedOperation,
                      closestNumber: state.closestToTarget.closestNumber,
                      isWaitingForSecond: state.isReadyForSecondNumber,
                      canUndo: state.canUndo,
                      isPlaying: state.isPlaying,
                      onNumberTap: controller.selectNumber,
                      onOperationTap: controller.selectOperation,
                      onUndo: controller.undo,
                      onReset: controller.resetGame,
                      onSubmit: () {
                        controller.submitAnswer();
                        // Result screen gösterilecek
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Result overlay
          if (state.status == GameStatus.submitted)
            ScoreDisplay(
              targetNumber: state.targetNumber,
              closestNumber: state.closestToTarget.closestNumber,
              distance: state.closestToTarget.distance,
              baseScore: state.score,
              timeBonus: state.timeBonus,
              totalScore: state.totalScore,
              isSolved: state.isSolved,
              onPlayAgain: () {
                controller.startRandomGame();
              },
              onContinue: () {
                // Güncel state'i al (closure problemini önlemek için)
                final currentState = ref.read(numberGameControllerProvider);

                // Solver ile en iyi çözümü bul
                final solver = BacktrackingSolver();
                final solverResult = solver.solve(
                  currentState.initialNumbers,
                  currentState.targetNumber,
                );

                // En iyi çözümü formatla
                final bestSolutionText = solverResult.steps.isEmpty
                    ? 'Sayılardan biri zaten hedef'
                    : solverResult.steps
                        .map((s) => s.displayString)
                        .join('\n');

                // Debug log
                debugPrint('=== Number Game Result ===');
                debugPrint('Initial Numbers: ${currentState.initialNumbers}');
                debugPrint('Target: ${currentState.targetNumber}');
                debugPrint('Solver Result: ${solverResult.result}');
                debugPrint('Solver Steps: ${solverResult.steps.length}');
                debugPrint('Best Solution Text: $bestSolutionText');

                // Sonuç ekranına git
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.roundResult,
                  arguments: RoundResultArgs(
                    roundNumber: widget.roundNumber,
                    totalRounds: widget.totalRounds,
                    isWordGame: false,
                    userAnswer: currentState.closestToTarget.closestNumber.toString(),
                    bestAnswer: solverResult.isExact
                        ? '${currentState.targetNumber} (Tam!)'
                        : '${solverResult.result} (${solverResult.distance} fark)',
                    baseScore: currentState.score,
                    timeBonus: currentState.timeBonus,
                    bestSolution: bestSolutionText,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(NumberGameState state) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Timer - CircularTimer ile aynı tasarım
            CircularTimer(
              timeRemaining: state.timeRemaining,
              totalTime: 90, // Sayı oyunu 90 saniye
            ),

            const Spacer(),

            // Title
            Column(
              children: [
                // Tur bilgisi
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Tur ${widget.roundNumber}/${widget.totalRounds}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'BİR İŞLEM',
                  style: AppTypography.primaryLabel,
                ),
              ],
            ),

            const Spacer(),

            // Symmetry spacer (same width as timer)
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
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
