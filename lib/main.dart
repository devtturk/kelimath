import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'core/services/secure_storage_service.dart';
import 'core/theme/theme.dart';
import 'core/router/app_router.dart';
import 'features/home/presentation/screens/screens.dart';
import 'features/game_session/application/game_session_provider.dart';
import 'features/profile/application/application.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Firebase başlat
    await Firebase.initializeApp();

    // Crashlytics ayarları
    if (!kDebugMode) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    }

    // Hive başlat
    await Hive.initFlutter();

    // Şifreli box'ları aç (kullanıcı verileri korunur)
    await SecureStorageService.initializeEncryptedBoxes();

    // Status bar ve navigation bar ayarları
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    runApp(
      const ProviderScope(
        child: KeliMathApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('Yakalanmamış hata: $error');
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}

class KeliMathApp extends StatelessWidget {
  const KeliMathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeliMath',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      home: const _HomeWrapper(),
    );
  }
}

/// HomeScreen wrapper - navigasyon için context gerekli.
class _HomeWrapper extends ConsumerStatefulWidget {
  const _HomeWrapper();

  @override
  ConsumerState<_HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends ConsumerState<_HomeWrapper> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    try {
      // Firebase anonim giriş yap
      await ref.read(userProfileProvider.notifier).signInAnonymously();
    } catch (e) {
      debugPrint('Firebase auth hatası: $e');
    }
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Auth başlatılana kadar yükleme göster
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    // Profil verilerini dinle
    final profileAsync = ref.watch(userProfileProvider);

    return HomeScreen(
      onStartGame: () {
        // Profil yüklenmiş mi kontrol et
        final profile = profileAsync.value;

        // Tutorial tamamlanmamışsa tutorial'a yönlendir
        if (profile == null || !profile.hasCompletedTutorial) {
          Navigator.pushNamed(context, AppRoutes.tutorialWord);
          return;
        }

        // Normal oyun akışı
        // Oyun oturumunu başlat (4 tur = 2 kelime + 2 sayı, her oyun ayrı tur)
        ref.read(gameSessionProvider.notifier).startGame(totalRounds: 4);

        // Harf seçimine git (1. tur = kelime oyunu)
        Navigator.pushNamed(
          context,
          AppRoutes.letterSelection,
          arguments: const LetterSelectionArgs(
            roundNumber: 1,
            totalRounds: 4,
          ),
        );
      },
      onHowToPlay: () {
        // Nasıl oynanır ekranını göster
        Navigator.pushNamed(
          context,
          AppRoutes.howToPlayWord,
          arguments: const HowToPlayWordArgs(
            showNumberGameNext: false,
          ),
        );
      },
      // Settings V1.0'da yok - buton gizli
      onSettings: null,
    );
  }
}
