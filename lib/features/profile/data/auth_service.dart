/// Authentication servisi arayüzü.
///
/// Şu an Hive tabanlı lokal auth kullanılıyor.
/// Gelecekte Firebase entegre edilebilir.
abstract class AuthService {
  /// Mevcut kullanıcı ID'si.
  String? get currentUserId;

  /// Kullanıcı giriş yapmış mı?
  bool get isSignedIn;

  /// Anonim giriş yap.
  Future<String> signInAnonymously();

  /// Çıkış yap.
  Future<void> signOut();
}
