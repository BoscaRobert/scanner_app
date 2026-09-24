// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get languageSelector => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get romanian => 'Romanian';

  @override
  String get home => 'Home';

  @override
  String get inputScreen => 'Input';

  @override
  String get connections => 'Connections';

  @override
  String get barcodeScanner => 'Barcode Scanner';
}
