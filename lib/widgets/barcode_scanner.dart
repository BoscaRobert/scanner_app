import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/dialog/dialog_builder.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'package:scanner_app/l10n/app_localizations.dart';

class BarcodeScannerPage extends StatefulWidget{
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {

  late MobileScannerController _mobileScannerController;

  bool flash = false;
  bool reverseCam=false;
  bool _canScan=false;

  @override
  void initState()
  {
    super.initState();
    _mobileScannerController=MobileScannerController();
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      top:false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.barcodeScanner),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
          ),
          ),
        body: MobileScanner(
          controller: _mobileScannerController,
          onDetect: (result) async{
            if(_canScan==false) return;
            _canScan=false;
            if(result.barcodes.isEmpty || result.barcodes.first.rawValue==''){return;}
            print("barcode: ${result.barcodes.first.rawValue}");
            await showDialog<void>(
              context: context, 
              builder: DialogBuilder.buildDialog(context,result,accept,reject), 
            );
          },
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              FloatingActionButton.small(
                onPressed: () async {
                  try {
                    await _mobileScannerController.toggleTorch();
                    setState ((){flash=!flash;});
                  } catch(e)
                    {
                      debugPrint('Torch toggle failed: $e');
                    }
                  },
                  child: Icon(flash?Icons.flash_on:Icons.flash_off),
              ),
              GestureDetector(
                onTapDown: (_){_canScan=true;},
                onTapUp: (_){_canScan=false;},
                onTapCancel: (){_canScan=false;},
                child: FloatingActionButton(
                  onPressed: () => (),
                  child: const Icon(Icons.barcode_reader),
                ),
              ),
              FloatingActionButton.small(
                onPressed: () async {
                  try {
                    await _mobileScannerController.switchCamera();
                    setState ((){reverseCam=!reverseCam;});
                  } catch(e)
                    {
                      debugPrint('Can flip failed: $e');
                    }
                  },
                  child: Icon(reverseCam?Icons.camera_rear:Icons.camera_front),
              )
            ],
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Navbar(),
      )
    );
  }
  void accept()
  {
    ;
  }
  void reject()
  {
    ;
  }
}