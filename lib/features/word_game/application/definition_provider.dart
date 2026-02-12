import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data.dart';

/// Definition servisi provider.
final definitionServiceProvider = Provider<DefinitionService>((ref) {
  return DefinitionService();
});

/// Tek kelime tanımı için async provider.
///
/// Kullanım:
/// ```dart
/// final definition = ref.watch(wordDefinitionProvider('KITAP'));
/// ```
final wordDefinitionProvider =
    FutureProvider.family<WordDefinition?, String>((ref, word) async {
  final service = ref.watch(definitionServiceProvider);
  return service.getDefinition(word);
});

/// Birden fazla kelime için tanım provider.
///
/// Kullanım:
/// ```dart
/// final definitions = ref.watch(multiWordDefinitionProvider(['KITAP', 'KALEM']));
/// ```
final multiWordDefinitionProvider =
    FutureProvider.family<Map<String, WordDefinition?>, List<String>>((
  ref,
  words,
) async {
  final service = ref.watch(definitionServiceProvider);
  return service.getDefinitions(words);
});

/// Cache istatistikleri için provider.
final definitionCacheStatsProvider = Provider<int>((ref) {
  final service = ref.watch(definitionServiceProvider);
  return service.cachedWordCount;
});
