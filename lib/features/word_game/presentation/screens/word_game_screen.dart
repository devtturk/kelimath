import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../core/router/app_router.dart';
import '../../application/application.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

/// Kelime oyunu ana ekranı.
class WordGameScreen extends ConsumerStatefulWidget {
  const WordGameScreen({
    super.key,
    this.roundNumber = 1,
    this.totalRounds = 4,
    this.onGameComplete,
  });

  final int roundNumber;
  final int totalRounds;
  final void Function(int score, int timeBonus)? onGameComplete;

  @override
  ConsumerState<WordGameScreen> createState() => _WordGameScreenState();
}

class _WordGameScreenState extends ConsumerState<WordGameScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final controller = ref.read(wordGameControllerProvider.notifier);
    controller.updateGuess(_textController.text);
  }

  void _navigateToResult(WordGameState state, {bool timeUp = false}) {
    if (_hasNavigated) return;
    _hasNavigated = true;

    // Süre bittiyse önce uyarı göster
    if (timeUp) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => _TimeUpDialog(
          userWord: state.currentGuess.isEmpty ? null : state.currentGuess,
          score: state.score,
          onContinue: () {
            Navigator.of(ctx).pop();
            _goToResultScreen(state);
          },
        ),
      );
    } else {
      _goToResultScreen(state);
    }
  }

  Future<void> _goToResultScreen(WordGameState state) async {
    final userWord = state.currentGuess.isEmpty ? '-' : state.currentGuess;
    final bestWord = state.bestPossibleWord ?? 'ÖRNEK';

    // Tanımları paralel çek (kelimeler varsa)
    String? userDefinition;
    String? bestDefinition;

    if (userWord != '-' || bestWord.isNotEmpty) {
      final definitionService = ref.read(definitionServiceProvider);

      // Paralel olarak her iki tanımı da çek
      final futures = await Future.wait([
        if (userWord != '-')
          definitionService.getDefinition(userWord)
        else
          Future.value(null),
        if (bestWord.isNotEmpty)
          definitionService.getDefinition(bestWord)
        else
          Future.value(null),
      ]);

      // Sonuçları al
      final userDef = futures.isNotEmpty ? futures[0] : null;
      final bestDef = futures.length > 1 ? futures[1] : null;

      // İlk anlamı al
      userDefinition = userDef?.meanings.firstOrNull;
      bestDefinition = bestDef?.meanings.firstOrNull;
    }

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.roundResult,
      arguments: RoundResultArgs(
        roundNumber: widget.roundNumber,
        totalRounds: widget.totalRounds,
        isWordGame: true,
        userAnswer: userWord,
        bestAnswer: bestWord,
        baseScore: state.score,
        timeBonus: state.timeBonus,
        userWordDefinition: userDefinition,
        bestWordDefinition: bestDefinition,
      ),
    );
  }

  void _onSubmit() async {
    final controller = ref.read(wordGameControllerProvider.notifier);
    await controller.submitAnswer();

    if (!mounted) return;

    final state = ref.read(wordGameControllerProvider);
    if (state.isSubmitted) {
      _navigateToResult(state);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wordGameControllerProvider);
    final controller = ref.read(wordGameControllerProvider.notifier);

    // Süre bittiğinde otomatik submit ve yönlendirme
    ref.listen<WordGameState>(wordGameControllerProvider, (previous, next) {
      if (previous != null &&
          previous.status == GameStatus.playing &&
          next.status == GameStatus.submitted &&
          next.timeRemaining <= 0 &&
          !_hasNavigated) {
        // Süre doldu, dialog göster
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _navigateToResult(next, timeUp: true);
          }
        });
      }
    });

    // Sync text controller with state (for external updates like clear)
    // Use post-frame callback to avoid modifying provider during build
    // Türkçe karakterleri doğru karşılaştır
    if (_turkishToUpper(_textController.text) != state.currentGuess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _turkishToUpper(_textController.text) != state.currentGuess) {
          _textController.removeListener(_onTextChanged);
          _textController.text = state.currentGuess;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: state.currentGuess.length),
          );
          _textController.addListener(_onTextChanged);
        }
      });
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showExitDialog();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundAlt,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            // Header with back button
            GameHeader(
              title: 'Kelime Turu',
              score: state.totalScore,
              timeRemaining: state.timeRemaining,
              onBack: _showExitDialog,
            ),

          // Main game area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Tried words list (scrollable)
                  if (state.triedWords.isNotEmpty)
                    _TriedWordsList(
                      words: state.triedWords,
                      selectedIndex: state.selectedWordIndex,
                      onSelect: controller.selectWord,
                      onRemove: controller.removeWord,
                    ),

                  const Spacer(),

                  // Joker indicator - sadece joker kullanıldığında göster
                  if (state.jokerUsed && state.jokerLetter != null)
                    _JokerUsedIndicator(jokerLetter: state.jokerLetter!),

                  const SizedBox(height: 16),

                  // Word input display
                  WordInputDisplay(
                    guess: state.currentGuess,
                    jokerUsed: state.jokerUsed,
                    jokerLetter: state.jokerLetter,
                    invalidIndices: state.invalidLetterIndices,
                    maxLength: 9,
                  ),

                  const SizedBox(height: 8),

                  // Hint text
                  Text(
                    state.triedWords.isEmpty
                        ? 'KELİME YAZ VE EKLE BUTONUNA BAS'
                        : 'YENİ KELİME DENE VEYA SEÇİLİ KELİMEYİ GÖNDER',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Letter rack
                  LetterRack(
                    letters: state.availableLetters,
                    usedLetters: _getUsedLetterIndices(state),
                    hasJoker: state.hasJoker,
                    jokerUsed: state.jokerUsed,
                    onLetterTap: (letter) {
                      _textController.text += letter;
                    },
                    onJokerTap: () {
                      // Joker is auto-used when needed
                    },
                  ),

                  const Spacer(),

                  // Action buttons with Add button
                  _ActionButtonsWithAdd(
                    onClear: () {
                      _textController.clear();
                      controller.clearGuess();
                    },
                    onAdd: state.canAddWord
                        ? () => controller.addCurrentWordToList()
                        : null,
                    onSubmit: state.canSubmit ? _onSubmit : null,
                    hasSelectedWord: state.selectedWordIndex != null,
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

            // Keyboard (custom Turkish)
            TurkishKeyboard(
              onKeyTap: (key) {
                if (state.isPlaying && state.lettersReady) {
                  _textController.text += key;
                }
              },
              onBackspace: () {
                if (_textController.text.isNotEmpty) {
                  _textController.text = _textController.text
                      .substring(0, _textController.text.length - 1);
                }
              },
              onClear: () {
                _textController.clear();
                controller.clearGuess();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => _ExitConfirmDialog(
        onConfirm: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  /// Türkçe karakterleri doğru şekilde büyük harfe dönüştürür.
  String _turkishToUpper(String text) {
    const turkishLowerToUpper = {
      'i': 'İ',
      'ı': 'I',
      'ğ': 'Ğ',
      'ü': 'Ü',
      'ş': 'Ş',
      'ö': 'Ö',
      'ç': 'Ç',
    };
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      buffer.write(turkishLowerToUpper[char] ?? char.toUpperCase());
    }
    return buffer.toString();
  }

  List<int> _getUsedLetterIndices(WordGameState state) {
    final usedIndices = <int>[];
    final availableCopy = List<String>.from(state.availableLetters);

    for (final char in state.currentGuess.split('')) {
      final index = availableCopy.indexOf(char);
      if (index != -1) {
        // Find original index
        int originalIndex = -1;
        for (int i = 0; i < state.availableLetters.length; i++) {
          if (state.availableLetters[i] == char && !usedIndices.contains(i)) {
            originalIndex = i;
            break;
          }
        }
        if (originalIndex != -1) {
          usedIndices.add(originalIndex);
          availableCopy[index] = ''; // Mark as used
        }
      }
    }

    return usedIndices;
  }

}

/// Joker kullanıldı göstergesi.
class _JokerUsedIndicator extends StatelessWidget {
  const _JokerUsedIndicator({required this.jokerLetter});

  final String jokerLetter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.15),
            AppColors.gold.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome,
            color: AppColors.gold,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            'JOKER: ',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.gold,
            ),
          ),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                jokerLetter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Süre bitti dialog'u.
class _TimeUpDialog extends StatefulWidget {
  const _TimeUpDialog({
    required this.userWord,
    required this.score,
    required this.onContinue,
  });

  final String? userWord;
  final int score;
  final VoidCallback onContinue;

  @override
  State<_TimeUpDialog> createState() => _TimeUpDialogState();
}

class _TimeUpDialogState extends State<_TimeUpDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surface,
                      AppColors.surfaceDark,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.timerWarning.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.timerWarning.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Timer icon with animation
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.timerWarning.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.timerWarning.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.timer_off_rounded,
                        color: AppColors.timerWarning,
                        size: 36,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'SÜRE DOLDU!',
                      style: AppTypography.headingMedium.copyWith(
                        color: AppColors.timerWarning,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // User's word (if any)
                    if (widget.userWord != null && widget.userWord!.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.borderLight.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Yazdığın kelime',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.userWord!,
                              style: AppTypography.headingSmall.copyWith(
                                color: AppColors.primary,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: AppColors.error,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Kelime yazamadın',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // Score display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Puan: ',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        Text(
                          '${widget.score}',
                          style: AppTypography.headingMedium.copyWith(
                            color: widget.score > 0
                                ? AppColors.success
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'DEVAM ET',
                              style: AppTypography.buttonPrimary.copyWith(
                                color: AppColors.textOnPrimary,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Denenen kelimeler listesi.
class _TriedWordsList extends StatelessWidget {
  const _TriedWordsList({
    required this.words,
    required this.selectedIndex,
    required this.onSelect,
    required this.onRemove,
  });

  final List<TriedWord> words;
  final int? selectedIndex;
  final void Function(int) onSelect;
  final void Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          final isSelected = index == selectedIndex;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 6,
              right: index == words.length - 1 ? 0 : 6,
            ),
            child: _TriedWordChip(
              word: word,
              isSelected: isSelected,
              onTap: () => onSelect(index),
              onRemove: () => onRemove(index),
            ),
          );
        },
      ),
    );
  }
}

/// Denenen kelime chip'i.
class _TriedWordChip extends StatelessWidget {
  const _TriedWordChip({
    required this.word,
    required this.isSelected,
    required this.onTap,
    required this.onRemove,
  });

  final TriedWord word;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.primary.withValues(alpha: 0.1),
                  ],
                )
              : null,
          color: isSelected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Seçili göstergesi
            if (isSelected) ...[
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 6),
            ],

            // Kelime
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      word.word,
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textWhite,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    if (word.jokerUsed) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'J',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  '${word.estimatedScore} puan',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),

            // Silme butonu
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: AppColors.error,
                  size: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Aksiyon butonları (Sil + Ekle + Gönder).
class _ActionButtonsWithAdd extends StatelessWidget {
  const _ActionButtonsWithAdd({
    required this.onClear,
    required this.onAdd,
    required this.onSubmit,
    required this.hasSelectedWord,
  });

  final VoidCallback onClear;
  final VoidCallback? onAdd;
  final VoidCallback? onSubmit;
  final bool hasSelectedWord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Clear button
          GestureDetector(
            onTap: onClear,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Icon(
                Icons.backspace_outlined,
                color: AppColors.textMuted,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Add button
          GestureDetector(
            onTap: onAdd,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: onAdd != null
                    ? LinearGradient(
                        colors: [
                          AppColors.success.withValues(alpha: 0.2),
                          AppColors.success.withValues(alpha: 0.1),
                        ],
                      )
                    : null,
                color: onAdd != null ? null : AppColors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(
                  color: onAdd != null
                      ? AppColors.success
                      : AppColors.borderLight,
                ),
              ),
              child: Icon(
                Icons.add_rounded,
                color: onAdd != null
                    ? AppColors.success
                    : AppColors.textMuted,
                size: 24,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Submit button
          Expanded(
            child: PrimaryButton(
              label: hasSelectedWord ? 'SEÇİLİ GÖNDER' : 'GÖNDER',
              icon: Icons.send,
              onPressed: onSubmit,
              isEnabled: onSubmit != null,
            ),
          ),
        ],
      ),
    );
  }
}

/// Oyundan çıkış onay dialogu.
class _ExitConfirmDialog extends StatelessWidget {
  const _ExitConfirmDialog({
    required this.onConfirm,
    required this.onCancel,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surface,
              AppColors.surfaceDark,
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.borderLight.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.timerWarning.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.exit_to_app_rounded,
                color: AppColors.timerWarning,
                size: 32,
              ),
            ),

            const SizedBox(height: 20),

            // Title
            Text(
              'Oyundan Çık',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textWhite,
              ),
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              'Oyundan çıkmak istediğine emin misin?\nİlerleme kaydedilmeyecek.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                // Cancel
                Expanded(
                  child: GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Center(
                        child: Text(
                          'Devam Et',
                          style: AppTypography.buttonSecondary.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Çık',
                          style: AppTypography.buttonPrimary.copyWith(
                            color: AppColors.textWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
