import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../word_game/application/application.dart';
import '../../../word_game/domain/domain.dart';
import '../../../word_game/presentation/widgets/widgets.dart';
import '../../application/application.dart';
import '../../domain/domain.dart';

/// Kelime oyunu tutorial ekranı.
/// Gerçek WordGameController kullanır, sadece üstüne tutorial ipuçları ekler.
class TutorialWordScreen extends ConsumerStatefulWidget {
  const TutorialWordScreen({super.key});

  @override
  ConsumerState<TutorialWordScreen> createState() => _TutorialWordScreenState();
}

class _TutorialWordScreenState extends ConsumerState<TutorialWordScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isNavigating = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized && mounted) {
        _isInitialized = true;
        // Tutorial state'i başlat
        ref.read(tutorialControllerProvider.notifier).startWordTutorial();
        // Gerçek oyunu sabit harflerle başlat
        ref.read(wordGameControllerProvider.notifier).startGame(
          letters: TutorialScenario.wordLetters,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final controller = ref.read(wordGameControllerProvider.notifier);
    controller.updateGuess(_textController.text);

    // Tutorial state'i de güncelle
    ref.read(tutorialControllerProvider.notifier).updateWord(
      _turkishToUpper(_textController.text),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(wordGameControllerProvider);
    final gameController = ref.read(wordGameControllerProvider.notifier);
    final tutorialState = ref.watch(tutorialControllerProvider);
    final tutorialController = ref.read(tutorialControllerProvider.notifier);

    // Tutorial tamamlandıysa sayı tutorial'ına geç
    if (!_isNavigating &&
        (tutorialState.phase == TutorialPhase.number ||
            tutorialState.phase == TutorialPhase.completed)) {
      _isNavigating = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (tutorialState.isSkipped ||
            tutorialState.phase == TutorialPhase.completed) {
          _finishTutorial();
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.tutorialNumber);
        }
      });
      return const SizedBox.shrink();
    }

    // Text controller sync
    if (_turkishToUpper(_textController.text) != gameState.currentGuess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _turkishToUpper(_textController.text) != gameState.currentGuess) {
          _textController.removeListener(_onTextChanged);
          _textController.text = gameState.currentGuess;
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: gameState.currentGuess.length),
          );
          _textController.addListener(_onTextChanged);
        }
      });
    }

    final currentStep = tutorialState.currentStep;

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Gerçek oyun ekranı
          Column(
            children: [
              // Header - Demo badge ile
              _buildDemoHeader(tutorialController),

              // Main game area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      // Tried words list
                      if (gameState.triedWords.isNotEmpty)
                        _TriedWordsList(
                          words: gameState.triedWords,
                          selectedIndex: gameState.selectedWordIndex,
                          onSelect: gameController.selectWord,
                          onRemove: gameController.removeWord,
                        ),

                      const Spacer(),

                      // Joker indicator
                      if (gameState.jokerUsed && gameState.jokerLetter != null)
                        _JokerUsedIndicator(jokerLetter: gameState.jokerLetter!),

                      const SizedBox(height: 16),

                      // Word input display
                      WordInputDisplay(
                        guess: gameState.currentGuess,
                        jokerUsed: gameState.jokerUsed,
                        jokerLetter: gameState.jokerLetter,
                        invalidIndices: gameState.invalidLetterIndices,
                        maxLength: 9,
                      ),

                      const SizedBox(height: 8),

                      // Hint text
                      Text(
                        gameState.triedWords.isEmpty
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
                        letters: gameState.availableLetters,
                        usedLetters: _getUsedLetterIndices(gameState),
                        hasJoker: gameState.hasJoker,
                        jokerUsed: gameState.jokerUsed,
                        onLetterTap: (letter) {
                          _textController.text += letter;
                        },
                        onJokerTap: () {},
                      ),

                      // Tutorial hint bubble (between letters and buttons)
                      if (currentStep != null &&
                          currentStep.action != TutorialAction.showInfo)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: _buildHintBubble(currentStep.instruction),
                        )
                      else
                        const Spacer(),

                      // Action buttons
                      _ActionButtonsWithAdd(
                        onClear: () {
                          _textController.clear();
                          gameController.clearGuess();
                        },
                        onAdd: gameState.canAddWord
                            ? () {
                                gameController.addCurrentWordToList();
                                // Tutorial adımını tamamla (add button step)
                                if (currentStep?.action == TutorialAction.tapAddButton) {
                                  tutorialController.completeStep();
                                }
                              }
                            : null,
                        onSubmit: gameState.canSubmit
                            ? () {
                                // Tutorial adımını tamamla (submit step)
                                if (currentStep?.action == TutorialAction.tapSubmitButton) {
                                  tutorialController.completeStep();
                                }
                              }
                            : null,
                        hasSelectedWord: gameState.selectedWordIndex != null,
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              // Keyboard
              TurkishKeyboard(
                onKeyTap: (key) {
                  if (gameState.isPlaying && gameState.lettersReady) {
                    _textController.text += key;
                    // Hedef kelimeye ulaşıldıysa freeType adımını tamamla
                    _checkFreeTypeComplete(tutorialState, tutorialController);
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
                  gameController.clearGuess();
                },
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

  void _checkFreeTypeComplete(TutorialState tutorialState, TutorialController tutorialController) {
    final currentStep = tutorialState.currentStep;
    if (currentStep?.action == TutorialAction.freeTypeWord) {
      final currentWord = _turkishToUpper(_textController.text);
      if (currentWord == TutorialScenario.targetWord) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            tutorialController.completeStep();
          }
        });
      }
    }
  }

  Widget _buildDemoHeader(TutorialController controller) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              'KELİME TURU',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textWhite,
              ),
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
                      Icons.lightbulb_outline,
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

  List<int> _getUsedLetterIndices(WordGameState state) {
    final usedIndices = <int>[];
    final availableCopy = List<String>.from(state.availableLetters);

    for (final char in state.currentGuess.split('')) {
      final index = availableCopy.indexOf(char);
      if (index != -1) {
        int originalIndex = -1;
        for (int i = 0; i < state.availableLetters.length; i++) {
          if (state.availableLetters[i] == char && !usedIndices.contains(i)) {
            originalIndex = i;
            break;
          }
        }
        if (originalIndex != -1) {
          usedIndices.add(originalIndex);
          availableCopy[index] = '';
        }
      }
    }

    return usedIndices;
  }

  void _finishTutorial() {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.letterSelection,
      arguments: const LetterSelectionArgs(roundNumber: 1, totalRounds: 4),
    );
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
            color: isSelected ? AppColors.primary : AppColors.borderLight,
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
            if (isSelected) ...[
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 6),
            ],
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
