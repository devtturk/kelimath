import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/router/app_router.dart';
import '../../application/word_game_controller.dart';
import '../../domain/domain.dart';

/// Harf seçimi ekranı - Profesyonel tasarım.
class LetterSelectionScreen extends ConsumerStatefulWidget {
  const LetterSelectionScreen({
    super.key,
    this.roundNumber = 1,
    this.totalRounds = 4,
    this.onComplete,
  });

  final int roundNumber;
  final int totalRounds;
  final VoidCallback? onComplete;

  @override
  ConsumerState<LetterSelectionScreen> createState() =>
      _LetterSelectionScreenState();
}

class _LetterSelectionScreenState extends ConsumerState<LetterSelectionScreen>
    with TickerProviderStateMixin {
  bool _hasNavigated = false;
  late AnimationController _headerController;
  late AnimationController _gridController;
  late AnimationController _controlsController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _gridFade;
  late Animation<double> _controlsFade;
  late Animation<Offset> _controlsSlide;

  @override
  void initState() {
    super.initState();

    // Header animasyonu
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _headerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));

    // Grid animasyonu
    _gridController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _gridFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gridController, curve: Curves.easeOut),
    );

    // Controls animasyonu
    _controlsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controlsFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controlsController, curve: Curves.easeOut),
    );
    _controlsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controlsController, curve: Curves.easeOut));

    // Animasyonları sırayla başlat
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _gridController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _controlsController.forward();
    });

    // Manuel oyun modunu başlat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wordGameControllerProvider.notifier).startManualGame();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _gridController.dispose();
    _controlsController.dispose();
    super.dispose();
  }

  void _navigateToWordGame() {
    if (_hasNavigated) return;
    _hasNavigated = true;

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.wordGame,
      arguments: WordGameArgs(
        roundNumber: widget.roundNumber,
        totalRounds: widget.totalRounds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wordGameControllerProvider);
    final controller = ref.read(wordGameControllerProvider.notifier);

    // 8 harf tamamlandığında otomatik olarak oyuna geç
    ref.listen<WordGameState>(wordGameControllerProvider, (previous, next) {
      if (next.lettersReady && !(previous?.lettersReady ?? false)) {
        // Haptic feedback
        HapticFeedback.mediumImpact();
        // Kısa bir gecikme ile geçiş yap (animasyon için)
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted && !_hasNavigated) {
            _navigateToWordGame();
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Animated background
          const _AnimatedBackground(),

          // Main content
          Column(
            children: [
              // Header with animation
              SlideTransition(
                position: _headerSlide,
                child: FadeTransition(
                  opacity: _headerFade,
                  child: _buildHeader(context),
                ),
              ),

              // Main content
              Expanded(
                child: FadeTransition(
                  opacity: _gridFade,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),

                        // Instruction text
                        _InstructionText(letterCount: state.availableLetters.length),

                        const SizedBox(height: 32),

                        // Letter grid with animations
                        _AnimatedLetterGrid(letters: state.availableLetters),

                        const SizedBox(height: 32),

                        // Progress indicator
                        _AnimatedProgressIndicator(
                          selected: state.availableLetters.length,
                          total: 8,
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom control card with animation
              SlideTransition(
                position: _controlsSlide,
                child: FadeTransition(
                  opacity: _controlsFade,
                  child: _ControlCard(
                    onVowel: () {
                      HapticFeedback.lightImpact();
                      controller.addVowel();
                    },
                    onConsonant: () {
                      HapticFeedback.lightImpact();
                      controller.addConsonant();
                    },
                    onRandom: () {
                      HapticFeedback.mediumImpact();
                      controller.startRandomGame();
                      _navigateToWordGame();
                    },
                    canAddMore: state.availableLetters.length < 8,
                    isComplete: state.lettersReady,
                    onContinue: () {
                      if (!state.lettersReady) {
                        controller.completeLetters();
                      }
                      _navigateToWordGame();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Back button
            _GlassIconButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'KELİME OYUNU',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tur ${widget.roundNumber}/${widget.totalRounds}',
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
            ),
            // Placeholder for balance
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

/// Instruction text widget.
class _InstructionText extends StatelessWidget {
  const _InstructionText({required this.letterCount});

  final int letterCount;

  @override
  Widget build(BuildContext context) {
    final isComplete = letterCount >= 8;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(isComplete),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isComplete
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isComplete
                ? AppColors.success.withValues(alpha: 0.3)
                : AppColors.borderLight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isComplete ? Icons.check_circle_rounded : Icons.touch_app_rounded,
              color: isComplete ? AppColors.success : AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              isComplete
                  ? 'Harfler hazır! Oyun başlıyor...'
                  : 'Sesli veya sessiz harf seçin',
              style: AppTypography.bodyMedium.copyWith(
                color: isComplete ? AppColors.success : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated letter grid with staggered animations.
class _AnimatedLetterGrid extends StatelessWidget {
  const _AnimatedLetterGrid({required this.letters});

  final List<String> letters;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final hasLetter = index < letters.length;
        final isNext = index == letters.length;

        if (hasLetter) {
          return _AnimatedFilledSlot(
            letter: letters[index],
            index: index,
          );
        } else {
          return _AnimatedEmptySlot(
            isActive: isNext,
            index: index,
          );
        }
      },
    );
  }
}

/// Animated filled slot with pop-in effect.
class _AnimatedFilledSlot extends StatefulWidget {
  const _AnimatedFilledSlot({
    required this.letter,
    required this.index,
  });

  final String letter;
  final int index;

  @override
  State<_AnimatedFilledSlot> createState() => _AnimatedFilledSlotState();
}

class _AnimatedFilledSlotState extends State<_AnimatedFilledSlot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _rotateAnimation = Tween<double>(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.surfaceLight,
                    AppColors.surface,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.letter,
                  style: AppTypography.tileLarge.copyWith(
                    fontSize: 32,
                    shadows: [
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated empty slot with pulse effect.
class _AnimatedEmptySlot extends StatefulWidget {
  const _AnimatedEmptySlot({
    this.isActive = false,
    required this.index,
  });

  final bool isActive;
  final int index;

  @override
  State<_AnimatedEmptySlot> createState() => _AnimatedEmptySlotState();
}

class _AnimatedEmptySlotState extends State<_AnimatedEmptySlot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_AnimatedEmptySlot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isActive ? _pulseAnimation.value : 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.slotEmpty,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isActive
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : AppColors.slotBorder,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              boxShadow: widget.isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 15,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: widget.isActive
                ? Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: AppColors.primary.withValues(alpha: 0.4),
                      size: 28,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}

/// Animated progress indicator.
class _AnimatedProgressIndicator extends StatelessWidget {
  const _AnimatedProgressIndicator({
    required this.selected,
    required this.total,
  });

  final int selected;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = selected / total;

    return Column(
      children: [
        // Progress bar
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Text indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$selected',
              style: AppTypography.headingMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            Text(
              ' / $total',
              style: AppTypography.headingMedium.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'harf',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Glass icon button.
class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.borderLight.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.textWhite,
          size: 22,
        ),
      ),
    );
  }
}

/// Alt kontrol kartı - Profesyonel tasarım.
class _ControlCard extends StatelessWidget {
  const _ControlCard({
    required this.onVowel,
    required this.onConsonant,
    required this.onRandom,
    required this.canAddMore,
    required this.isComplete,
    required this.onContinue,
  });

  final VoidCallback onVowel;
  final VoidCallback onConsonant;
  final VoidCallback onRandom;
  final bool canAddMore;
  final bool isComplete;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.surface.withValues(alpha: 0.8),
            AppColors.surface,
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(color: AppColors.borderLight.withValues(alpha: 0.5)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderMedium,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            if (canAddMore) ...[
              // Vowel / Consonant buttons
              Row(
                children: [
                  Expanded(
                    child: _SelectionButton(
                      label: 'SESLİ',
                      sublabel: 'A E I İ O Ö U Ü',
                      icon: Icons.record_voice_over_rounded,
                      color: AppColors.primary,
                      onTap: onVowel,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SelectionButton(
                      label: 'SESSİZ',
                      sublabel: 'B C D F G ...',
                      icon: Icons.text_fields_rounded,
                      color: AppColors.gold,
                      onTap: onConsonant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Random button
              _RandomButton(onTap: onRandom),
            ] else ...[
              // Ready state - auto continues
              _ReadyIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}

/// Selection button (Sesli/Sessiz).
class _SelectionButton extends StatefulWidget {
  const _SelectionButton({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String sublabel;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  State<_SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<_SelectionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.color.withValues(alpha: 0.3),
          ),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.2),
                    blurRadius: 15,
                    spreadRadius: -5,
                  ),
                ],
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              color: widget.color,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: AppTypography.buttonSecondary.copyWith(
                color: widget.color,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.sublabel,
              style: AppTypography.labelSmall.copyWith(
                color: widget.color.withValues(alpha: 0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Random button.
class _RandomButton extends StatefulWidget {
  const _RandomButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_RandomButton> createState() => _RandomButtonState();
}

class _RandomButtonState extends State<_RandomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.textMuted.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shuffle_rounded,
              color: AppColors.textMuted,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              'Rastgele Doldur',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Ready indicator when letters are complete.
class _ReadyIndicator extends StatefulWidget {
  @override
  State<_ReadyIndicator> createState() => _ReadyIndicatorState();
}

class _ReadyIndicatorState extends State<_ReadyIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 48,
        ),
        const SizedBox(height: 12),
        Text(
          'Harfler Hazır!',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.success,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final delay = i * 0.2;
                final value =
                    (((_controller.value + delay) % 1.0) * 2 - 1).abs();
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success.withValues(alpha: 0.3 + value * 0.7),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}

/// Animated background.
class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _BackgroundPainter(
            animation: _controller.value,
            primaryColor: AppColors.primary,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    required this.animation,
    required this.primaryColor,
  });

  final double animation;
  final Color primaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final orb1Center = Offset(
      size.width * 0.7 + math.sin(animation * 2 * math.pi) * 30,
      size.height * 0.15 + math.cos(animation * 2 * math.pi) * 20,
    );

    final orb2Center = Offset(
      size.width * 0.3 + math.cos(animation * 2 * math.pi) * 25,
      size.height * 0.85 + math.sin(animation * 2 * math.pi) * 30,
    );

    final orb1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.06),
          primaryColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: orb1Center, radius: 150));

    final orb2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.04),
          primaryColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: orb2Center, radius: 200));

    canvas.drawCircle(orb1Center, 150, orb1Paint);
    canvas.drawCircle(orb2Center, 200, orb2Paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
