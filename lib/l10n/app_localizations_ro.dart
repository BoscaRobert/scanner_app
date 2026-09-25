// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get languageSelector => 'Selecteaza Limba';

  @override
  String get english => 'Engleza';

  @override
  String get romanian => 'Romana';

  @override
  String get home => 'Acasa';

  @override
  String get inputScreen => 'Inregistrare';

  @override
  String get connections => 'Conexiune';

  @override
  String get barcodeScanner => 'Cititor Bara de Cod';

  @override
  String get connectionTestYes => 'Testul de conexiune a avut success';

  @override
  String get connectionTestNo => 'Testul de conexiune nu a avut success';

  @override
  String get hostAddress => 'Adresa IPv4 al gazdei';

  @override
  String get enterHostWarning => 'Introdu intai adresa IPv4 al gazdei';

  @override
  String get barcode => 'Cod de bare';

  @override
  String get inputPrompt => 'Cod de bare introdus:';

  @override
  String get proceed => 'Doresti sa trimiti?';

  @override
  String get yes => 'da';

  @override
  String get no => 'nu';

  @override
  String get barcodeCancel => 'cod de bare anulat';

  @override
  String get barcodeSentSuccessfully => 'cod transmis cu success';

  @override
  String get barcodeTransmissionError => 'eroare transmitere cod';
}
