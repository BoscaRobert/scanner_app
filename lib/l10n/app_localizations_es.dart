// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get helloWorld => '¡Hola Mundo!';

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
