import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/main.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  static const List<({Locale locale, FlagsCode flag, String name})> languages = [
    (locale: Locale('en', 'GB'), flag: FlagsCode.GB, name: 'English'),
    (locale: Locale('ro', 'RO'), flag: FlagsCode.RO, name: 'Romanian'),
  ];

  void _onLanguageSelected(BuildContext context, Locale locale) {
    MyApp.setLocale(context,locale);
    debugPrint('Selected: $locale');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16), // rounded corners
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max, // wrap content height
            children: [
              Text(AppLocalizations.of(context)!.languageSelector),
              for (final lang in languages) ...[
                _LanguageButton(
                  flag: lang.flag,
                  label: lang.name,
                  onPressed: () => _onLanguageSelected(context, lang.locale),
                ),
                if (lang != languages.last) const SizedBox(height: 5),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({
    required this.flag,
    required this.label,
    required this.onPressed,
  });

  final FlagsCode flag;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Flag.fromCode(flag, height: 20, width: 30),
          ),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}