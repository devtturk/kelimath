import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

/// Hive şifreleme anahtarlarını güvenli şekilde yöneten servis.
///
/// Platform keychain/keystore kullanarak encryption key'i güvenli saklar.
/// Bu sayede Hive box'ları şifreli açılabilir.
class SecureStorageService {
  static const _encryptionKeyName = 'hive_encryption_key';

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Hive şifreleme anahtarını alır veya oluşturur.
  ///
  /// İlk çağrıda yeni bir anahtar oluşturulur ve güvenli depolanır.
  /// Sonraki çağrılarda depolanan anahtar döndürülür.
  static Future<List<int>> getEncryptionKey() async {
    try {
      final existingKey = await _storage.read(key: _encryptionKeyName);

      if (existingKey != null) {
        return base64Url.decode(existingKey);
      }

      // Yeni anahtar oluştur
      final newKey = Hive.generateSecureKey();
      await _storage.write(
        key: _encryptionKeyName,
        value: base64UrlEncode(newKey),
      );

      return newKey;
    } catch (_) {
      // Hata durumunda yeni anahtar oluştur (eski veriler kaybolur)
      final newKey = Hive.generateSecureKey();
      try {
        await _storage.write(
          key: _encryptionKeyName,
          value: base64UrlEncode(newKey),
        );
      } catch (_) {
        // Yazma da başarısız olursa geçici anahtar kullan
      }
      return newKey;
    }
  }

  /// Şifreli Hive box açar.
  ///
  /// [boxName] - Açılacak box'ın adı
  /// [encryptionKey] - Şifreleme anahtarı (null ise otomatik alınır)
  static Future<Box<T>> openEncryptedBox<T>(
    String boxName, {
    List<int>? encryptionKey,
  }) async {
    final key = encryptionKey ?? await getEncryptionKey();
    return Hive.openBox<T>(
      boxName,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  /// Tüm şifreli box'ları açar (uygulama başlangıcında).
  ///
  /// Dictionary box şifrelenmez (public data).
  static Future<void> initializeEncryptedBoxes() async {
    final key = await getEncryptionKey();

    // Kullanıcı verileri şifreli
    await Hive.openBox(
      'user_profile',
      encryptionCipher: HiveAesCipher(key),
    );
    await Hive.openBox(
      'statistics',
      encryptionCipher: HiveAesCipher(key),
    );
    await Hive.openBox(
      'achievements',
      encryptionCipher: HiveAesCipher(key),
    );
    await Hive.openBox(
      'game_history',
      encryptionCipher: HiveAesCipher(key),
    );

    // Dictionary ve cache şifrelenmez (public data, performans için)
    await Hive.openBox('dictionary');
    await Hive.openBox<String>('word_definitions');
  }

  /// Şifreleme anahtarını siler (veri sıfırlama için).
  static Future<void> deleteEncryptionKey() async {
    await _storage.delete(key: _encryptionKeyName);
  }
}
