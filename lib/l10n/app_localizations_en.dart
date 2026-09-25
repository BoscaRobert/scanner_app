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

  @override
  String get connectionTestYes => 'Connection test successfull';

  @override
  String get connectionTestNo => 'Connection test unsuccessfull';

  @override
  String get hostAddress => 'Host IPv4 Address';

  @override
  String get enterHostWarning => 'Please enter a host';

  @override
  String get barcode => 'Barcode';

  @override
  String get inputPrompt => 'Barcode introduced:';

  @override
  String get proceed => 'Do you want to proceed?';

  @override
  String get yes => 'yes';

  @override
  String get no => 'no';

  @override
  String get barcodeCancel => 'barcode canceled';

  @override
  String get barcodeSentSuccessfully => 'barcode sent successfully';

  @override
  String get barcodeTransmissionError => 'barcode transmission error';
}
