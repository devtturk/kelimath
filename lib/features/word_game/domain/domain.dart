// Word Game Domain Layer - Barrel Export
export 'dictionary/dictionary.dart';
export 'letter_generator.dart';
export 'letter_validation.dart';
export 'word_game_state.dart';
export 'word_scoring_utils.dart';

// Re-export GameStatus from number_game (shared enum)
export '../../number_game/domain/number_game_state.dart' show GameStatus;
