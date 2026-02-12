import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

/// Firebase tabanlı Authentication servisi.
/// Anonim giriş destekler, ileride Google Sign-In eklenebilir.
class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? get currentUserId => _auth.currentUser?.uid;

  @override
  bool get isSignedIn => _auth.currentUser != null;

  /// Mevcut kullanıcı objesi.
  User? get currentUser => _auth.currentUser;

  /// Auth state değişikliklerini dinle.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<String> signInAnonymously() async {
    // Mevcut kullanıcı varsa onu döndür
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }

    // Yeni anonim kullanıcı oluştur
    final userCredential = await _auth.signInAnonymously();
    final user = userCredential.user;
    if (user == null) {
      throw Exception('Firebase anonim giriş başarısız: kullanıcı oluşturulamadı');
    }
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Kullanıcının anonim olup olmadığını kontrol et.
  bool get isAnonymous => _auth.currentUser?.isAnonymous ?? true;
}
