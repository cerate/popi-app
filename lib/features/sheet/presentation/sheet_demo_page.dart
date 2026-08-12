import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/app_sheet.dart';
import '../../../shared/widgets/app_toast.dart';

class SheetDemoPage extends StatelessWidget {
  const SheetDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.sheetDemo)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          FilledButton.icon(
            onPressed: () => _showModalSheet(context),
            icon: const Icon(Icons.vertical_align_bottom),
            label: Text(l10n.modalSheet),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _showDraggableSheet(context),
            icon: const Icon(Icons.open_in_full),
            label: Text(l10n.draggableSheet),
          ),
        ],
      ),
    );
  }

  void _showModalSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    AppSheet.show<void>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          children: [
            Text(l10n.modalSheet,
                style: Theme.of(context).textTheme.titleLarge),
            ListTile(
              leading: const Icon(Icons.copy_outlined),
              title: Text(l10n.copyAction),
              onTap: () {
                Navigator.pop(context);
                AppToast.success(context, l10n.copyAction);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: Text(l10n.shareAction),
              onTap: () {
                Navigator.pop(context);
                AppToast.info(context, l10n.shareAction);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDraggableSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    AppSheet.showDraggable<void>(
      context: context,
      builder: (context, scrollController) => ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        itemCount: 12,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text('${l10n.item} ${index + 1}'),
          subtitle: Text(l10n.draggableSheet),
        ),
      ),
    );
  }
}
