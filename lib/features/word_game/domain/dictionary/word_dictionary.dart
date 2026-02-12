/// Kelime sözlüğü abstract interface.
///
/// Bu interface, farklı sözlük implementasyonları için
/// ortak bir arayüz sağlar:
/// - MockDictionary: Test/MVP için lokal sözlük
/// - FirebaseDictionary: Production için Firebase sözlük
/// - ApiDictionary: REST API tabanlı sözlük
abstract class WordDictionary {
  /// Sözlüğü başlatır (veri yüklemesi vb.).
  ///
  /// Birden fazla çağrılması güvenlidir (idempotent).
  Future<void> initialize();

  /// Kelimenin sözlükte olup olmadığını kontrol eder.
  ///
  /// [word]: Kontrol edilecek kelime (büyük/küçük harf duyarsız).
  ///
  /// Döndürür: Kelime geçerliyse true.
  Future<bool> isValidWord(String word);

  /// Kelimenin anlamını/tanımını getirir.
  ///
  /// [word]: Anlamı istenilen kelime.
  ///
  /// Döndürür: Kelime anlamı veya null (bulunamazsa).
  Future<String?> getDefinition(String word);

  /// Verilen harflerle yazılabilecek tüm geçerli kelimeleri bulur.
  ///
  /// [letters]: Mevcut harf listesi (8 harf).
  /// [includeJoker]: Joker dahil mi? (Joker = herhangi bir harf).
  ///
  /// Döndürür: Geçerli kelimeler listesi (uzunluğa göre sıralı).
  Future<List<String>> findValidWords(
    List<String> letters, {
    bool includeJoker = true,
  });

  /// Sözlükteki toplam kelime sayısını döner.
  Future<int> getWordCount();

  /// Sözlüğün hazır olup olmadığını kontrol eder.
  ///
  /// Bazı implementasyonlar (Firebase, API) ilk yüklemede
  /// zaman alabilir.
  Future<bool> isReady();
}

/// Sözlük sorgu sonucu.
///
/// Detaylı kelime bilgisi için kullanılır.
class DictionaryEntry {
  const DictionaryEntry({
    required this.word,
    this.definition,
    this.partOfSpeech,
    this.examples,
  });

  /// Kelime.
  final String word;

  /// Kelime anlamı/tanımı.
  final String? definition;

  /// Kelime türü (isim, fiil, sıfat vb.).
  final String? partOfSpeech;

  /// Örnek cümleler.
  final List<String>? examples;
}
