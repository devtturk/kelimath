import 'package:flutter/material.dart';

import '../../features/home/presentation/screens/screens.dart';
import '../../features/word_game/presentation/screens/screens.dart';
import '../../features/number_game/presentation/number_game_screen.dart';
import '../../features/game_session/presentation/screens/screens.dart';
import '../../features/profile/presentation/screens/screens.dart';
import '../../features/tutorial/presentation/screens/screens.dart';

/// Uygulama route isimleri.
abstract final class AppRoutes {
  static const String home = '/';
  static const String howToPlayWord = '/how-to-play/word';
  static const String howToPlayNumber = '/how-to-play/number';
  static const String letterSelection = '/game/word/selection';
  static const String wordGame = '/game/word/play';
  static const String numberGame = '/game/number/play';
  static const String roundResult = '/game/result/round';
  static const String finalResult = '/game/result/final';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String avatarSelection = '/profile/avatar';
  static const String tutorialWord = '/tutorial/word';
  static const String tutorialNumber = '/tutorial/number';
  static const String tutorialComplete = '/tutorial/complete';
}

/// Uygulama route generator.
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _buildRoute(const HomeScreen());

      case AppRoutes.howToPlayWord:
        final args = settings.arguments as HowToPlayWordArgs?;
        return _buildRoute(
          HowToPlayWordScreen(
            onComplete: args?.onComplete,
            showNumberGameNext: args?.showNumberGameNext ?? true,
          ),
        );

      case AppRoutes.letterSelection:
        final args = settings.arguments as LetterSelectionArgs?;
        return _buildRoute(
          LetterSelectionScreen(
            roundNumber: args?.roundNumber ?? 1,
            totalRounds: args?.totalRounds ?? 3,
            onComplete: args?.onComplete,
          ),
        );

      case AppRoutes.wordGame:
        final args = settings.arguments as WordGameArgs?;
        return _buildRoute(
          WordGameScreen(
            roundNumber: args?.roundNumber ?? 1,
            totalRounds: args?.totalRounds ?? 4,
            onGameComplete: args?.onGameComplete,
          ),
        );

      case AppRoutes.numberGame:
        final args = settings.arguments as NumberGameArgs?;
        return _buildRoute(
          NumberGameScreen(
            roundNumber: args?.roundNumber ?? 1,
            totalRounds: args?.totalRounds ?? 4,
            onGameComplete: args?.onGameComplete,
          ),
        );

      case AppRoutes.roundResult:
        final args = settings.arguments as RoundResultArgs;
        return _buildRoute(
          RoundResultScreen(
            roundNumber: args.roundNumber,
            totalRounds: args.totalRounds,
            isWordGame: args.isWordGame,
            userAnswer: args.userAnswer,
            bestAnswer: args.bestAnswer,
            baseScore: args.baseScore,
            timeBonus: args.timeBonus,
            userWordDefinition: args.userWordDefinition,
            bestWordDefinition: args.bestWordDefinition,
            bestSolution: args.bestSolution,
            onContinue: args.onContinue,
          ),
        );

      case AppRoutes.finalResult:
        final args = settings.arguments as FinalResultArgs;
        return _buildRoute(
          FinalResultScreen(
            totalScore: args.totalScore,
            roundScores: args.roundScores,
            totalTime: args.totalTime,
            onPlayAgain: args.onPlayAgain,
            onHome: args.onHome,
          ),
        );

      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen());

      case AppRoutes.avatarSelection:
        return _buildRoute(const AvatarSelectionScreen());

      case AppRoutes.tutorialWord:
        return _buildRoute(const TutorialWordScreen());

      case AppRoutes.tutorialNumber:
        return _buildRoute(const TutorialNumberScreen());

      case AppRoutes.tutorialComplete:
        return _buildRoute(const TutorialCompleteScreen());

      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Text('Route not found: ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute<T> _buildRoute<T>(Widget page) {
    return MaterialPageRoute<T>(builder: (_) => page);
  }
}

// === ROUTE ARGUMENTS ===

class HowToPlayWordArgs {
  const HowToPlayWordArgs({
    this.onComplete,
    this.showNumberGameNext = true,
  });

  final VoidCallback? onComplete;
  final bool showNumberGameNext;
}

class LetterSelectionArgs {
  const LetterSelectionArgs({
    this.roundNumber = 1,
    this.totalRounds = 4,
    this.onComplete,
  });

  final int roundNumber;
  final int totalRounds;
  final VoidCallback? onComplete;
}

class WordGameArgs {
  const WordGameArgs({
    this.roundNumber = 1,
    this.totalRounds = 4,
    this.onGameComplete,
  });

  final int roundNumber;
  final int totalRounds;
  final void Function(int score, int timeBonus)? onGameComplete;
}

class NumberGameArgs {
  const NumberGameArgs({
    this.roundNumber = 1,
    this.totalRounds = 4,
    this.onGameComplete,
  });

  final int roundNumber;
  final int totalRounds;
  final void Function(int score, int timeBonus)? onGameComplete;
}

class RoundResultArgs {
  const RoundResultArgs({
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
}

class FinalResultArgs {
  const FinalResultArgs({
    required this.totalScore,
    required this.roundScores,
    this.totalTime,
    this.onPlayAgain,
    this.onHome,
  });

  final int totalScore;
  final List<RoundScore> roundScores;
  final Duration? totalTime;
  final VoidCallback? onPlayAgain;
  final VoidCallback? onHome;
}
