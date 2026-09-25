import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/dialog/dialog_builder.dart';
import 'package:scanner_app/networking/connection.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/widgets/snack_bar_message.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late MobileScannerController _mobileScannerController;

  bool flash = false;
  bool reverseCam = false;
  bool _canScan = false;
  double _currentZoom = 0;

  @override
  void initState() {
    super.initState();
    _mobileScannerController = MobileScannerController(
      autoZoom: true,
      initialZoom: 0,
      cameraResolution: Size(1920,1080),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.barcodeScanner),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        
        body: Stack(
          children: [
          MobileScanner(
            controller: _mobileScannerController,
            onDetect: (result) async {
              if (_canScan == false) return;
              _canScan = false;
              if (result.barcodes.isEmpty ||
                  result.barcodes.first.rawValue == '') {
                return;
              }
          
              final String scanned = result.barcodes.first.rawValue!;
              debugPrint("barcode: $scanned");
          
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) => DialogBuilder.buildDialog(
                  context,
                  result,
                  () => accept(scanned),   // wrap so it matches the no-arg signature
                  reject,
                  '${AppLocalizations.of(context)!.inputPrompt}$scanned\n${AppLocalizations.of(context)!.proceed}',
                ),
              );
              
            },
          ),
          Positioned(
            top:10,
            left:10,
            child: Row(
              children: [
                FloatingActionButton.small(
                  onPressed: () async {
                    try {
                      await _mobileScannerController.toggleTorch();
                      changeLense(_mobileScannerController);
                    } catch (e) {
                      debugPrint('Cam Lens Change Fail: $e');
                    }
                  },
                  child: Icon(Icons.lens_outlined)
                ),
                Center(widthFactor: 1.7,child: 
                  Slider(value: _currentZoom, min:0, max:1, onChanged: (value) {
                  setState(() {
                    _currentZoom=value;
                  });
                  _mobileScannerController.setZoomScale(value);
                  })
                  ),
              ],
            )
          ),
          ]
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.small(
              onPressed: () async {
                try {
                  await _mobileScannerController.toggleTorch();
                  setState(() {
                    flash = !flash;
                  });
                } catch (e) {
                  debugPrint('Torch toggle failed: $e');
                }
              },
              child: Icon(flash ? Icons.flash_on : Icons.flash_off),
            ),
            GestureDetector(
              onTapDown: (_) {
                _canScan = true;
              },
              onTapUp: (_) {
                _canScan = false;
              },
              onTapCancel: () {
                _canScan = false;
              },
              child: FloatingActionButton(
                onPressed: () => (),
                child: const Icon(Icons.barcode_reader),
              ),
            ),
            FloatingActionButton.small(
              onPressed: () async {
                try {
                  await _mobileScannerController.switchCamera();
                  setState(() {
                    reverseCam = !reverseCam;
                  });
                } catch (e) {
                  debugPrint('Can flip failed: $e');
                }
              },
              child: Icon(reverseCam ? Icons.camera_rear : Icons.camera_front),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Navbar(),
      ),
    );
  }

  Future<void> accept(String text) async{
    bool result = await ServerConnection.sendIdToServer(text);
    if(result)
    {
      showMessage(
      context,
      text: AppLocalizations.of(context)!.barcodeSentSuccessfully,
      background: Colors.green,);
    }
    else
    {
      showMessage(
      context,
      text: AppLocalizations.of(context)!.barcodeTransmissionError,
      background: Colors.red,);
    }
  }

  void reject() {
    showMessage(
      context,
      text: AppLocalizations.of(context)!.barcodeCancel,
      background: Colors.yellow,
    );
  }

  void changeLense(MobileScannerController con)
  {
    con.switchCamera(ToggleLensType());
    setState(() {
      _currentZoom=0;
    });
    con.resetZoomScale();
  }
}