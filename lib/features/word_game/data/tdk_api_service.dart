import 'dart:convert';

import 'package:http/http.dart' as http;

import 'word_definition.dart';

/// TDK Sözlük API servisi.
///
/// Kelimelerin anlamlarını TDK'dan çeker.
class TdkApiService {
  TdkApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _baseUrl = 'https://sozluk.gov.tr/gts';

  /// Kelimenin tanımını TDK'dan çeker.
  ///
  /// [word] küçük harfle gönderilmeli.
  /// Başarısız olursa null döner.
  Future<WordDefinition?> fetchDefinition(String word) async {
    try {
      final normalizedWord = _turkishToLower(word);
      // URL encode ile Türkçe karakterleri düzgün gönder
      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {'ara': normalizedWord},
      );

      final response = await _client.get(uri).timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode != 200) {
        return null;
      }

      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      // TDK hata döndüğünde {"error": "..."} formatında gelir
      if (json is Map && json.containsKey('error')) {
        return WordDefinition(
          word: word,
          meanings: ['Tanım bulunamadı'],
          cachedAt: DateTime.now(),
        );
      }

      if (json is! List || json.isEmpty) {
        return WordDefinition(
          word: word,
          meanings: ['Tanım bulunamadı'],
          cachedAt: DateTime.now(),
        );
      }

      return WordDefinition.fromTdkResponse(word, json);
    } catch (e) {
      // Ağ hatası veya timeout
      return null;
    }
  }

  /// Türkçe karakterleri doğru şekilde küçük harfe dönüştürür.
  /// Dart'ın toLowerCase() metodu Türkçe İ/I dönüşümünü doğru yapmaz.
  String _turkishToLower(String text) {
    const turkishUpperToLower = {
      'İ': 'i', // noktalı İ -> noktalı i
      'I': 'ı', // noktasız I -> noktasız ı
      'Ğ': 'ğ',
      'Ü': 'ü',
      'Ş': 'ş',
      'Ö': 'ö',
      'Ç': 'ç',
    };

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      buffer.write(turkishUpperToLower[char] ?? char.toLowerCase());
    }
    return buffer.toString();
  }
}
