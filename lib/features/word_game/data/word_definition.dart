import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_definition.freezed.dart';
part 'word_definition.g.dart';

/// Kelime tanımı modeli.
@freezed
abstract class WordDefinition with _$WordDefinition {
  const WordDefinition._();

  const factory WordDefinition({
    /// Kelime.
    required String word,

    /// Kelimenin anlamları listesi.
    required List<String> meanings,

    /// Kelimenin kökeni/etimolojisi (opsiyonel).
    String? origin,

    /// Örnek cümleler (opsiyonel).
    @Default([]) List<String> examples,

    /// Cache'lenme tarihi.
    DateTime? cachedAt,
  }) = _WordDefinition;

  factory WordDefinition.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionFromJson(json);

  /// TDK API yanıtından WordDefinition oluştur.
  ///
  /// Güvenli tip kontrolü ile response parse eder.
  /// Malformed data durumunda fallback değer döner.
  factory WordDefinition.fromTdkResponse(
    String word,
    List<dynamic> tdkResponse,
  ) {
    if (tdkResponse.isEmpty) {
      return WordDefinition(
        word: word,
        meanings: ['Tanım bulunamadı'],
        cachedAt: DateTime.now(),
      );
    }

    try {
      // İlk entry'i güvenli şekilde al
      final firstEntry = tdkResponse[0];
      if (firstEntry is! Map<String, dynamic>) {
        return _fallbackDefinition(word);
      }

      final entry = firstEntry;
      final meanings = <String>[];
      final examples = <String>[];

      // Anlamları güvenli şekilde al
      final anlamlarListe = entry['anlamlarListe'];
      if (anlamlarListe is List) {
        for (final anlam in anlamlarListe) {
          if (anlam is! Map<String, dynamic>) continue;

          final anlamText = anlam['anlam'];
          if (anlamText is String && anlamText.isNotEmpty) {
            meanings.add(anlamText);
          }

          // Örnekleri güvenli şekilde al
          final orneklerListe = anlam['orneklerListe'];
          if (orneklerListe is List) {
            for (final ornek in orneklerListe) {
              if (ornek is! Map<String, dynamic>) continue;

              final ornekText = ornek['ornek'];
              if (ornekText is String && ornekText.isNotEmpty) {
                examples.add(ornekText);
              }
            }
          }
        }
      }

      // Etimoloji
      final lisan = entry['lisan'];
      final origin = lisan is String ? lisan : null;

      return WordDefinition(
        word: word,
        meanings: meanings.isEmpty ? ['Tanım bulunamadı'] : meanings,
        origin: origin,
        examples: examples.take(3).toList(), // Max 3 örnek
        cachedAt: DateTime.now(),
      );
    } catch (_) {
      // Parse hatası durumunda fallback
      return _fallbackDefinition(word);
    }
  }

  /// Hata durumunda kullanılacak fallback tanım.
  static WordDefinition _fallbackDefinition(String word) {
    return WordDefinition(
      word: word,
      meanings: ['Tanım bulunamadı'],
      cachedAt: DateTime.now(),
    );
  }
}
