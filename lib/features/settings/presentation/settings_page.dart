import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/providers/settings_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.theme, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(value: ThemeMode.system, label: Text(l10n.system), icon: const Icon(Icons.brightness_auto)),
              ButtonSegment(value: ThemeMode.light, label: Text(l10n.light), icon: const Icon(Icons.light_mode_outlined)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.dark), icon: const Icon(Icons.dark_mode_outlined)),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) => ref.read(themeModeProvider.notifier).setThemeMode(selection.first),
          ),
          const SizedBox(height: 28),
          Text(l10n.language, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'zh', label: Text(l10n.chinese), icon: const Icon(Icons.translate)),
              ButtonSegment(value: 'en', label: Text(l10n.english), icon: const Icon(Icons.translate)),
            ],
            selected: {locale.languageCode},
            onSelectionChanged: (selection) => ref.read(localeProvider.notifier).setLocale(Locale(selection.first)),
          ),
        ],
      ),
    );
  }
}
