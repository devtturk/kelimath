import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

/// Nasıl oynanır ekranı - Kelime ve İşlem oyunu açıklamaları.
/// PageView ile 2 sayfa: Kelime oyunu ve İşlem oyunu.
class HowToPlayWordScreen extends StatefulWidget {
  const HowToPlayWordScreen({
    super.key,
    this.onComplete,
    this.showNumberGameNext = true,
  });

  final VoidCallback? onComplete;
  final bool showNumberGameNext;

  @override
  State<HowToPlayWordScreen> createState() => _HowToPlayWordScreenState();
}

class _HowToPlayWordScreenState extends State<HowToPlayWordScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Son sayfada - kapat
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Kapatma butonu - sağ üst köşede
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),

            // İçerik
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    border: Border.all(color: AppColors.borderLight),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowDark,
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // PageView
                      Flexible(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: [
                            _WordGamePage(),
                            _NumberGamePage(),
                          ],
                        ),
                      ),

                      // Footer (Indicators + Button)
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          // Page indicators
          PageIndicator(
            currentIndex: _currentPage,
            count: 2,
          ),
          const SizedBox(height: 24),

          // Action button
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: _currentPage == 1 ? 'ANLADIM' : 'DEVAM',
              icon: _currentPage == 1 ? Icons.check : Icons.arrow_forward,
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}

/// Kelime oyunu sayfası.
class _WordGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            child: Text(
              'Kelime Oyunu',
              style: AppTypography.headingLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Letter Tiles Illustration
          _buildLetterIllustration(),

          // Instructions
          _buildInstructions(),
        ],
      ),
    );
  }

  Widget _buildLetterIllustration() {
    final letters = ['K', 'A', 'L', 'E', 'M', 'L', 'İ', 'K'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Regular letter tiles
          ...letters.map((letter) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _LetterTile(letter: letter),
              )),
          // Joker tile
          const Padding(
            padding: EdgeInsets.only(left: 3),
            child: _JokerTile(),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    final instructions = [
      (Icons.grid_view, '8 harf verilir'),
      (Icons.straighten, 'En uzun kelimeyi yaz'),
      (Icons.auto_awesome, 'Joker 1 harfi tamamlar'),
      (Icons.star, 'Harf başına 10 puan'),
      (Icons.auto_awesome_outlined, 'Joker harfi 5 puan'),
      (Icons.emoji_events, '9 harfli kelime: 120 puan bonus'),
      (Icons.timer, '60 saniye süren var'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: instructions
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: IconLabelRow(
                    icon: item.$1,
                    label: item.$2,
                    iconColor: AppColors.primary,
                    iconBackgroundColor: AppColors.surfaceLight,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

/// İşlem oyunu sayfası.
class _NumberGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            child: Text(
              'İşlem Oyunu',
              style: AppTypography.headingLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Number Illustration
          _buildNumberIllustration(),

          // Instructions
          _buildInstructions(),
        ],
      ),
    );
  }

  Widget _buildNumberIllustration() {
    final numbers = ['25', '6', '3', '7', '10', '2'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          // Hedef sayı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag, color: AppColors.gold, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Hedef: 437',
                  style: AppTypography.headingMedium.copyWith(
                    color: AppColors.gold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Sayılar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbers
                .map((n) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _NumberTile(number: n),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    final instructions = [
      (Icons.calculate, '6 sayı verilir'),
      (Icons.flag, 'Hedefe ulaşmaya çalış'),
      (Icons.add, '+ − × ÷ işlemlerini kullan'),
      (Icons.timer, '90 saniye süren var'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: instructions
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: IconLabelRow(
                    icon: item.$1,
                    label: item.$2,
                    iconColor: AppColors.gold,
                    iconBackgroundColor: AppColors.surfaceLight,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

/// Harf taşı widget'ı (illustration için).
class _LetterTile extends StatelessWidget {
  const _LetterTile({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: AppTypography.tileMedium.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}

/// Sayı taşı widget'ı (illustration için).
class _NumberTile extends StatelessWidget {
  const _NumberTile({required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: AppTypography.tileMedium.copyWith(
            fontSize: number.length > 1 ? 14 : 18,
          ),
        ),
      ),
    );
  }
}

/// Joker taşı widget'ı (illustration için).
class _JokerTile extends StatelessWidget {
  const _JokerTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.jokerBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowPrimary,
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '?',
          style: AppTypography.tileMedium.copyWith(
            fontSize: 18,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

/// Modal olarak göstermek için helper.
Future<void> showHowToPlayWord(
  BuildContext context, {
  VoidCallback? onComplete,
  bool showNumberGameNext = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87,
    builder: (context) => HowToPlayWordScreen(
      onComplete: () {
        Navigator.of(context).pop();
        onComplete?.call();
      },
      showNumberGameNext: showNumberGameNext,
    ),
  );
}
