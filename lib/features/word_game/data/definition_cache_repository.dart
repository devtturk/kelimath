import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'word_definition.dart';

/// Kelime tanımları için Hive cache repository.
///
/// Lazy loading: Tanımlar ilk istendiğinde TDK'dan çekilir ve cache'lenir.
class DefinitionCacheRepository {
  DefinitionCacheRepository({String boxName = 'word_definitions'})
      : _boxName = boxName;

  final String _boxName;
  Box<String>? _box;
  Future<void>? _initFuture;

  /// Cache box'ını aç.
  Future<void> init() {
    _initFuture ??= _doInit();
    return _initFuture!;
  }

  Future<void> _doInit() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<String>(_boxName);
    }
  }

  /// Box'ın açık olduğundan emin ol.
  Box<String> get _safeBox {
    if (_box == null || !_box!.isOpen) {
      throw StateError(
        'DefinitionCacheRepository henüz başlatılmadı. init() çağırın.',
      );
    }
    return _box!;
  }

  /// Cache'den tanım al.
  ///
  /// Bulunamazsa null döner.
  WordDefinition? getCached(String word) {
    final key = word.toUpperCase();
    final jsonStr = _safeBox.get(key);

    if (jsonStr == null) return null;

    try {
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return WordDefinition.fromJson(json);
    } catch (e) {
      // Bozuk cache verisi, sil
      _safeBox.delete(key);
      return null;
    }
  }

  /// Tanımı cache'e kaydet.
  Future<void> cache(WordDefinition definition) async {
    final key = definition.word.toUpperCase();
    final jsonStr = jsonEncode(definition.toJson());
    await _safeBox.put(key, jsonStr);
  }

  /// Belirli bir kelimenin cache'de olup olmadığını kontrol et.
  bool isCached(String word) {
    final key = word.toUpperCase();
    return _safeBox.containsKey(key);
  }

  /// Cache'deki toplam kelime sayısı.
  int get cachedCount => _safeBox.length;

  /// Cache'i temizle.
  Future<void> clearCache() async {
    await _safeBox.clear();
  }

  /// Eski cache girişlerini temizle (30 günden eski).
  Future<int> pruneOldEntries({int maxAgeDays = 30}) async {
    final cutoff = DateTime.now().subtract(Duration(days: maxAgeDays));
    var pruned = 0;

    final keysToDelete = <String>[];

    for (final key in _safeBox.keys) {
      final jsonStr = _safeBox.get(key);
      if (jsonStr == null) continue;

      try {
        final json = jsonDecode(jsonStr) as Map<String, dynamic>;
        final definition = WordDefinition.fromJson(json);

        if (definition.cachedAt != null &&
            definition.cachedAt!.isBefore(cutoff)) {
          keysToDelete.add(key as String);
        }
      } catch (e) {
        // Bozuk veri, sil
        keysToDelete.add(key as String);
      }
    }

    for (final key in keysToDelete) {
      await _safeBox.delete(key);
      pruned++;
    }

    return pruned;
  }
}
