import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'dart:io';

class BarcodeScannerPage extends StatefulWidget{
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {

  late bool _canScan;

  late MobileScannerController _mobileScannerController;

  @override
  void initState()
  {
    super.initState();
    _mobileScannerController=MobileScannerController();
    _canScan=true;
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      top:false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Barcode Scanner'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
          ),
          ),
        body: MobileScanner(
          controller: _mobileScannerController,
          onDetect: (read) {
            if(_canScan==false) return;

            stdout.write("barcode: ${read.barcodes.first.rawValue}");
          },
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              FloatingActionButton.small(
                onPressed: ()=>(),
                child: const Icon(Icons.flash_auto)
              ) ,
              GestureDetector(
                onTapDown: (_) => _canScan=true,
                onTapUp: (_) => _canScan=false,
                onTapCancel: () => _canScan=false,
                child: FloatingActionButton(
                  onPressed: () => (),
                  child: const Icon(Icons.barcode_reader),
                ),
              ),
              FloatingActionButton.small(
                onPressed: ()=>(),
                child: const Icon(Icons.flip_camera_android)
              )
            ],
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Navbar(),
      )
    );
  }
}