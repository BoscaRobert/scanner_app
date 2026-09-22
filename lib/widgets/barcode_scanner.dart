import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerPage extends StatelessWidget{
  const BarcodeScannerPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MobileScanner();
  }
}