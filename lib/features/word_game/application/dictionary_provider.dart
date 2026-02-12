import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/dictionary/dictionary.dart';

/// Sözlük provider'ı.
/// Uygulama genelinde tek bir sözlük instance'ı kullanılır.
/// Singleton olarak oluşturulur, initialize() ayrıca çağrılmalıdır.
final dictionaryProvider = Provider<WordDictionary>((ref) {
  return HiveDictionary();
});

/// Sözlük hazır mı provider'ı.
/// Bu provider'ı watch ederek sözlüğün yüklenmesini bekleyebilirsiniz.
final dictionaryReadyProvider = FutureProvider<bool>((ref) async {
  final dictionary = ref.watch(dictionaryProvider);
  await dictionary.initialize();
  return true;
});
