import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/markdown_message.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.sheetDemo,
            icon: const Icon(Icons.vertical_align_bottom),
            onPressed: () => context.push('/sheet-demo'),
          ),
          IconButton(
            tooltip: l10n.chat,
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () => context.push('/chat'),
          ),
          IconButton(
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: MarkdownMessage(
          data: '''# Flutter Agent

这是一个支持 **Markdown** 的消息渲染示例。

```dart
final message = "Hello Agent";
```
''',
        ),
      ),
    );
  }
}
