import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emsafe_app/main.dart';

void main() {
  testWidgets('App starts on stage1 splash UI (auto navigate)', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Splash initial view.
    expect(find.byType(Scaffold), findsOneWidget);

    // Avanzamos el tiempo para que el splash ejecute su navegación y no queden timers pendientes.
    await tester.pump(const Duration(seconds: 6));
  });
}

