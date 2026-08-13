import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:popi_ai_app/features/chat/presentation/chat_page.dart';

void main() {
  testWidgets('renders the agent chat page', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ChatPage()),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI Agent'), findsOneWidget);
    expect(find.textContaining('Markdown'), findsOneWidget);
  });
}
