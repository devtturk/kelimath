import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kelimath/main.dart';

void main() {
  testWidgets('App loads NumberGameScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: KeliMathApp(),
      ),
    );

    // Uygulama yüklendiğinde "Sayı Oyunu" başlığını görmeli
    expect(find.text('Sayı Oyunu'), findsOneWidget);

    // Hedef etiketi görünmeli
    expect(find.text('HEDEF'), findsOneWidget);
  });
}
