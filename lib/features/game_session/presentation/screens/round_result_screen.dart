import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/router/app_router.dart';
import '../../application/game_session_provider.dart';

/// Tur sonuç ekranı - Profesyonel tasarım.
class RoundResultScreen extends ConsumerStatefulWidget {
  const RoundResultScreen({
    super.key,
    required this.roundNumber,
    required this.totalRounds,
    required this.isWordGame,
    required this.userAnswer,
    required this.bestAnswer,
    required this.baseScore,
    required this.timeBonus,
    this.userWordDefinition,
    this.bestWordDefinition,
    this.bestSolution,
    this.onContinue,
  });

  final int roundNumber;
  final int totalRounds;
  final bool isWordGame;
  final String userAnswer;
  final String bestAnswer;
  final int baseScore;
  final int timeBonus;
  /// Kullanıcının kelimesinin anlamı (kelime oyunu için).
  final String? userWordDefinition;
  /// En iyi kelimenin anlamı (kelime oyunu için).
  final String? bestWordDefinition;
  /// Çözüm adımları (sayı oyunu için).
  final String? bestSolution;
  final VoidCallback? onContinue;

  @override
  ConsumerState<RoundResultScreen> createState() => _RoundResultScreenState();
}

class _RoundResultScreenState extends ConsumerState<RoundResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _scoreController;
  late AnimationController _cardController;
  late AnimationController _buttonController;
  late AnimationController _confettiController;

  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;
  late Animation<double> _scoreFade;
  late Animation<double> _scoreScale;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _buttonFade;

  int get totalScore => widget.baseScore + widget.timeBonus;
  bool get isGoodScore => totalScore >= 50;
  bool get isPerfectScore => totalScore >= 100;

  @override
  void initState() {
    super.initState();

    // Header animation
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

    // Score animation
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scoreFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeOut),
    );
    _scoreScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.elasticOut),
    );

    // Card animation
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _cardFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOut),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut));

    // Button animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    // Confetti animation (for good scores)
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Start animations sequentially
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _scoreController.forward();
      if (isGoodScore) {
        HapticFeedback.mediumImpact();
        _confettiController.forward();
      }
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _cardController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _scoreController.dispose();
    _cardController.dispose();
    _buttonController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _handleContinue(BuildContext context) {
    HapticFeedback.lightImpact();

    // Debug log
    debugPrint('=== _handleContinue ===');
    debugPrint('roundNumber: ${widget.roundNumber}');
    debugPrint('totalRounds: ${widget.totalRounds}');
    debugPrint('isWordGame: ${widget.isWordGame}');

    // Puanı session'a kaydet
    final sessionNotifier = ref.read(gameSessionProvider.notifier);
    if (widget.isWordGame) {
      sessionNotifier.addWordScore(
        score: widget.baseScore,
        timeBonus: widget.timeBonus,
      );
    } else {
      sessionNotifier.addNumberScore(
        score: widget.baseScore,
        timeBonus: widget.timeBonus,
      );
    }

    final session = ref.read(gameSessionProvider);
    debugPrint('Session roundScores count: ${session.roundScores.length}');
    debugPrint('Session totalScore: ${session.totalScore}');

    if (widget.onContinue != null) {
      debugPrint('Using custom onContinue callback');
      widget.onContinue!();
    } else {
      // Her oyun ayrı bir tur: Kelime=1,3,5,7 Sayı=2,4,6,8
      // Sonraki tura geç
      final nextRound = widget.roundNumber + 1;

      if (nextRound > widget.totalRounds) {
        // Son tur bitti - Final sonuç ekranına git
        debugPrint('Last round! Going to final result screen');
        debugPrint('Final totalScore: ${session.totalScore}');
        debugPrint('Final roundScores: ${session.roundScores.length}');
        sessionNotifier.endGame();

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.finalResult,
          arguments: FinalResultArgs(
            totalScore: session.totalScore,
            roundScores: session.roundScores,
            totalTime: session.totalTime,
          ),
        );
      } else if (widget.isWordGame) {
        // Kelime oyunu bitti, sayı oyununa geç (tur artıyor)
        debugPrint('Going to number game, round: $nextRound');
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.numberGame,
          arguments: NumberGameArgs(
            roundNumber: nextRound,
            totalRounds: widget.totalRounds,
          ),
        );
      } else {
        // Sayı oyunu bitti, kelime oyununa geç (tur artıyor)
        debugPrint('Going to letter selection, round: $nextRound');
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.letterSelection,
          arguments: LetterSelectionArgs(
            roundNumber: nextRound,
            totalRounds: widget.totalRounds,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Animated background
          const _AnimatedBackground(),

          // Confetti (for good scores)
          if (isGoodScore)
            _ConfettiOverlay(
              controller: _confettiController,
              isPerfect: isPerfectScore,
            ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Header
                SlideTransition(
                  position: _headerSlide,
                  child: FadeTransition(
                    opacity: _headerFade,
                    child: _buildHeader(),
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Score display with animation
                        FadeTransition(
                          opacity: _scoreFade,
                          child: ScaleTransition(
                            scale: _scoreScale,
                            child: _ScoreDisplay(
                              totalScore: totalScore,
                              isGoodScore: isGoodScore,
                              isPerfectScore: isPerfectScore,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // User answer card
                        SlideTransition(
                          position: _cardSlide,
                          child: FadeTransition(
                            opacity: _cardFade,
                            child: _UserAnswerCard(
                              isWordGame: widget.isWordGame,
                              answer: widget.userAnswer,
                              baseScore: widget.baseScore,
                              timeBonus: widget.timeBonus,
                              definition: widget.userWordDefinition,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Best answer card
                        SlideTransition(
                          position: _cardSlide,
                          child: FadeTransition(
                            opacity: _cardFade,
                            child: _BestAnswerCard(
                              isWordGame: widget.isWordGame,
                              bestAnswer: widget.bestAnswer,
                              definition: widget.bestWordDefinition,
                              solution: widget.bestSolution,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // Continue button
                FadeTransition(
                  opacity: _buttonFade,
                  child: _buildContinueButton(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Game type indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.isWordGame
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.isWordGame
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : AppColors.gold.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.isWordGame ? Icons.abc_rounded : Icons.calculate_rounded,
                  color: widget.isWordGame ? AppColors.primary : AppColors.gold,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.isWordGame ? 'Kelime' : 'Sayı',
                  style: AppTypography.labelSmall.copyWith(
                    color: widget.isWordGame ? AppColors.primary : AppColors.gold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Round indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Text(
                  'Tur ',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  '${widget.roundNumber}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/${widget.totalRounds}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    final isLastRound = widget.roundNumber >= widget.totalRounds;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: SafeArea(
        top: false,
        child: _GlowingButton(
          label: isLastRound ? 'SONUÇLARI GÖR' : 'SONRAKİ TUR',
          icon: isLastRound ? Icons.emoji_events_rounded : Icons.arrow_forward_rounded,
          onPressed: () => _handleContinue(context),
        ),
      ),
    );
  }
}

/// Büyük puan gösterimi.
class _ScoreDisplay extends StatelessWidget {
  const _ScoreDisplay({
    required this.totalScore,
    required this.isGoodScore,
    required this.isPerfectScore,
  });

  final int totalScore;
  final bool isGoodScore;
  final bool isPerfectScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Score label
        Text(
          isPerfectScore ? 'MÜKEMMEL!' : isGoodScore ? 'HARİKA!' : 'TUR SONUCU',
          style: AppTypography.labelMedium.copyWith(
            color: isPerfectScore
                ? AppColors.gold
                : isGoodScore
                    ? AppColors.success
                    : AppColors.textMuted,
            letterSpacing: 3,
          ),
        ),

        const SizedBox(height: 8),

        // Score value
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isPerfectScore
                ? [AppColors.gold, AppColors.gold.withValues(alpha: 0.8)]
                : isGoodScore
                    ? [AppColors.success, AppColors.primary]
                    : [AppColors.textWhite, AppColors.textSecondary],
          ).createShader(bounds),
          child: Text(
            totalScore.toString(),
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1,
              shadows: [
                if (isGoodScore)
                  Shadow(
                    color: (isPerfectScore ? AppColors.gold : AppColors.success)
                        .withValues(alpha: 0.5),
                    blurRadius: 30,
                  ),
              ],
            ),
          ),
        ),

        Text(
          'PUAN',
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMuted,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}

/// Kullanıcı cevap kartı.
class _UserAnswerCard extends StatelessWidget {
  const _UserAnswerCard({
    required this.isWordGame,
    required this.answer,
    required this.baseScore,
    required this.timeBonus,
    this.definition,
  });

  final bool isWordGame;
  final String answer;
  final int baseScore;
  final int timeBonus;
  final String? definition;

  @override
  Widget build(BuildContext context) {
    final bool hasValidAnswer = answer.isNotEmpty && answer != '-';

    return Container(
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
        border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Answer display
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Label
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isWordGame ? 'SENİN KELİMEN' : 'SENİN SAYIN',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Answer
                if (isWordGame)
                  _AnimatedLetterTiles(word: answer)
                else
                  Text(
                    answer,
                    style: AppTypography.targetNumber.copyWith(
                      fontSize: 48,
                    ),
                  ),
              ],
            ),
          ),

          // Definition (for word game with valid answer)
          if (isWordGame && hasValidAnswer) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.borderLight.withValues(alpha: 0.3),
                ),
              ),
              child: definition != null && definition!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: AppColors.success,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'KELİME ANLAMI',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.success,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          definition!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.textMuted,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Kelime anlamı için TDK sözlüğüne bakınız',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textMuted,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],

          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: AppColors.borderLight.withValues(alpha: 0.3),
          ),

          // Score breakdown
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: _ScoreItem(
                    label: 'Puan',
                    value: baseScore,
                    color: AppColors.textWhite,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.borderLight.withValues(alpha: 0.3),
                ),
                Expanded(
                  child: _ScoreItem(
                    label: 'Süre Bonusu',
                    value: timeBonus,
                    color: AppColors.primary,
                    prefix: '+',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Score item in breakdown.
class _ScoreItem extends StatelessWidget {
  const _ScoreItem({
    required this.label,
    required this.value,
    required this.color,
    this.prefix = '',
  });

  final String label;
  final int value;
  final Color color;
  final String prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$prefix$value',
          style: AppTypography.headingMedium.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Animated letter tiles.
class _AnimatedLetterTiles extends StatelessWidget {
  const _AnimatedLetterTiles({required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    if (word.isEmpty || word == '-') {
      return Text(
        'Kelime bulunamadı',
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textMuted,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    // Dinamik boyutlandırma: 9 harfli kelimeler için daha küçük tile'lar
    final letterCount = word.length;
    final double tileWidth;
    final double tileHeight;
    final double fontSize;
    final double spacing;

    if (letterCount >= 9) {
      tileWidth = 30;
      tileHeight = 38;
      fontSize = 16;
      spacing = 4;
    } else if (letterCount >= 7) {
      tileWidth = 36;
      tileHeight = 44;
      fontSize = 19;
      spacing = 5;
    } else {
      tileWidth = 40;
      tileHeight = 48;
      fontSize = 22;
      spacing = 6;
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: word.split('').asMap().entries.map((entry) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 300 + entry.key * 50),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surfaceLight,
                      AppColors.surface,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(letterCount >= 9 ? 8 : 10),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: AppTypography.tileMedium.copyWith(
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

/// En iyi cevap kartı - Kelime oyunu için.
class _BestWordCard extends StatelessWidget {
  const _BestWordCard({
    required this.bestWord,
    this.definition,
  });

  final String bestWord;
  final String? definition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gold.withValues(alpha: 0.08),
            AppColors.gold.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.gold.withValues(alpha: 0.15),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.gold.withValues(alpha: 0.2),
                        AppColors.gold.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.gold,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EN İYİ KELİME',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.gold,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${bestWord.length} harf',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Word display
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: _AnimatedBestWord(word: bestWord),
            ),
          ),

          // Definition section
          if (definition != null && definition!.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderLight.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ANLAMI',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    definition!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Anlam yüklenmiyor mesajı
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderLight.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.textMuted,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Kelime anlamı için TDK sözlüğüne bakınız',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Animated best word display.
class _AnimatedBestWord extends StatelessWidget {
  const _AnimatedBestWord({required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    // Dinamik boyutlandırma: 9 harfli kelimeler için daha küçük tile'lar
    final letterCount = word.length;
    final double tileWidth;
    final double tileHeight;
    final double fontSize;
    final double spacing;

    if (letterCount >= 9) {
      tileWidth = 32;
      tileHeight = 40;
      fontSize = 18;
      spacing = 4;
    } else if (letterCount >= 7) {
      tileWidth = 38;
      tileHeight = 46;
      fontSize = 20;
      spacing = 6;
    } else {
      tileWidth = 44;
      tileHeight = 52;
      fontSize = 24;
      spacing = 8;
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: word.split('').asMap().entries.map((entry) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + entry.key * 80),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                width: tileWidth,
                height: tileHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.gold.withValues(alpha: 0.15),
                      AppColors.gold.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(letterCount >= 9 ? 8 : 12),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

/// En iyi cevap kartı - Sayı oyunu için.
class _BestNumberCard extends StatelessWidget {
  const _BestNumberCard({
    required this.bestAnswer,
    this.solution,
  });

  final String bestAnswer;
  final String? solution;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calculate_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EN İYİ ÇÖZÜM',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Hedefe en yakın sonuç',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Result display
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primary.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Text(
                  bestAnswer,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),

          // Solution steps
          if (solution != null && solution!.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderLight.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.format_list_numbered_rounded,
                        color: AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'ÇÖZÜM ADIMLARI',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.success,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...solution!.split('\n').asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                                fontFamily: 'monospace',
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Legacy best answer card (fallback).
class _BestAnswerCard extends StatelessWidget {
  const _BestAnswerCard({
    required this.isWordGame,
    required this.bestAnswer,
    this.definition,
    this.solution,
  });

  final bool isWordGame;
  final String bestAnswer;
  final String? definition;
  final String? solution;

  @override
  Widget build(BuildContext context) {
    if (isWordGame) {
      return _BestWordCard(
        bestWord: bestAnswer,
        definition: definition,
      );
    } else {
      return _BestNumberCard(
        bestAnswer: bestAnswer,
        solution: solution,
      );
    }
  }
}

/// Glowing button.
class _GlowingButton extends StatefulWidget {
  const _GlowingButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<_GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) {
            setState(() => _isPressed = false);
            widget.onPressed();
          },
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: _glowAnimation.value),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: AppTypography.buttonPrimary.copyWith(
                      color: AppColors.textOnPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    widget.icon,
                    color: AppColors.textOnPrimary,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
      duration: const Duration(seconds: 10),
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
      size.width * 0.8 + math.sin(animation * 2 * math.pi) * 40,
      size.height * 0.2 + math.cos(animation * 2 * math.pi) * 30,
    );

    final orb2Center = Offset(
      size.width * 0.2 + math.cos(animation * 2 * math.pi) * 30,
      size.height * 0.8 + math.sin(animation * 2 * math.pi) * 40,
    );

    final orb1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.06),
          primaryColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: orb1Center, radius: 180));

    final orb2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.04),
          primaryColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: orb2Center, radius: 220));

    canvas.drawCircle(orb1Center, 180, orb1Paint);
    canvas.drawCircle(orb2Center, 220, orb2Paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

/// Confetti overlay for good scores.
class _ConfettiOverlay extends StatelessWidget {
  const _ConfettiOverlay({
    required this.controller,
    required this.isPerfect,
  });

  final AnimationController controller;
  final bool isPerfect;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ConfettiPainter(
            progress: controller.value,
            isPerfect: isPerfect,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({
    required this.progress,
    required this.isPerfect,
  });

  final double progress;
  final bool isPerfect;

  final _random = math.Random(42);

  @override
  void paint(Canvas canvas, Size size) {
    final particleCount = isPerfect ? 40 : 20;

    for (int i = 0; i < particleCount; i++) {
      final startX = _random.nextDouble() * size.width;
      final startY = -20.0;
      final endY = size.height + 20;

      final currentY = startY + (endY - startY) * progress;
      final wobble = math.sin(progress * math.pi * 4 + i) * 20;
      final currentX = startX + wobble;

      final opacity = (1 - progress).clamp(0.0, 1.0);

      final colors = isPerfect
          ? [AppColors.gold, AppColors.primary, AppColors.success, Colors.white]
          : [AppColors.primary, AppColors.success];

      final color = colors[i % colors.length].withValues(alpha: opacity * 0.8);
      final paint = Paint()..color = color;

      final particleSize = 4.0 + _random.nextDouble() * 4;

      canvas.drawCircle(
        Offset(currentX, currentY),
        particleSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
