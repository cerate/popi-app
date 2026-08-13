import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:popi_ai_app/features/sheet/presentation/sheet_demo_page.dart';
import 'package:popi_ai_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('renders sheet demo actions', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('zh'),
        home: SheetDemoPage(),
      ),
    );

    expect(find.text('普通底部 Sheet'), findsOneWidget);
    expect(find.text('可拖拽 Sheet'), findsOneWidget);
  });
}
