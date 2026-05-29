import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../models/language_model.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final localeNotifier = ref.read(localeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTab),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.languageLabel),
            subtitle: Text(l10n.selectLanguage),
          ),
          const Divider(),
          ...LanguageModel.languages.map(
            (language) => RadioListTile<String>(
              value: language.code,
              groupValue: currentLocale.languageCode,
              onChanged: (value) async {
                if (value == null) return;

                await localeNotifier.setLocale(Locale(value));
              },
              title: Row(
                children: [
                  Text(
                    language.flag,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 12),
                  Text(language.name),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}