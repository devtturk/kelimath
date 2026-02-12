import 'definition_cache_repository.dart';
import 'tdk_api_service.dart';
import 'word_definition.dart';

/// Kelime tanımı servisi.
///
/// Hibrit yaklaşım:
/// 1. Önce cache'e bak
/// 2. Cache'de yoksa TDK API'den çek
/// 3. API'den gelen veriyi cache'le
class DefinitionService {
  DefinitionService({
    TdkApiService? apiService,
    DefinitionCacheRepository? cacheRepository,
  })  : _apiService = apiService ?? TdkApiService(),
        _cacheRepository = cacheRepository ?? DefinitionCacheRepository();

  final TdkApiService _apiService;
  final DefinitionCacheRepository _cacheRepository;

  bool _initialized = false;

  /// Servisi başlat.
  Future<void> init() async {
    if (_initialized) return;
    await _cacheRepository.init();
    _initialized = true;
  }

  /// Kelimenin tanımını al.
  ///
  /// Önce cache kontrol edilir, yoksa API'den çekilir.
  /// [forceRefresh] true ise cache atlanır.
  Future<WordDefinition?> getDefinition(
    String word, {
    bool forceRefresh = false,
  }) async {
    await init();

    final normalizedWord = _turkishToUpper(word);

    // Cache kontrolü
    if (!forceRefresh) {
      final cached = _cacheRepository.getCached(normalizedWord);
      if (cached != null) {
        return cached;
      }
    }

    // API'den çek
    final definition = await _apiService.fetchDefinition(normalizedWord);

    if (definition != null) {
      // Cache'e kaydet
      await _cacheRepository.cache(definition);
      return definition;
    }

    return null;
  }

  /// Birden fazla kelimenin tanımını al.
  ///
  /// Paralel olarak çeker, hız için.
  Future<Map<String, WordDefinition?>> getDefinitions(
    List<String> words,
  ) async {
    await init();

    final results = <String, WordDefinition?>{};

    // Önce cache'den al
    final uncached = <String>[];
    for (final word in words) {
      final normalizedWord = _turkishToUpper(word);
      final cached = _cacheRepository.getCached(normalizedWord);
      if (cached != null) {
        results[normalizedWord] = cached;
      } else {
        uncached.add(normalizedWord);
      }
    }

    // Cache'de olmayanları API'den çek (paralel)
    if (uncached.isNotEmpty) {
      final futures = uncached.map((word) async {
        final definition = await _apiService.fetchDefinition(word);
        if (definition != null) {
          await _cacheRepository.cache(definition);
        }
        return MapEntry(word, definition);
      });

      final entries = await Future.wait(futures);
      for (final entry in entries) {
        results[entry.key] = entry.value;
      }
    }

    return results;
  }

  /// Cache'deki kelime sayısı.
  int get cachedWordCount => _cacheRepository.cachedCount;

  /// Cache'i temizle.
  Future<void> clearCache() => _cacheRepository.clearCache();

  /// Eski cache girişlerini temizle.
  Future<int> pruneCache({int maxAgeDays = 30}) =>
      _cacheRepository.pruneOldEntries(maxAgeDays: maxAgeDays);

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
}
