import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emsafe_app/main.dart';

void main() {
  testWidgets('App starts on stage1 splash UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Continuar'), findsOneWidget);
  });
}

