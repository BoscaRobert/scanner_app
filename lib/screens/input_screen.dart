import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scanner_app/widgets/barcode_scanner.dart';
import 'package:scanner_app/widgets/carousel_pageview.dart';

class InputScreen extends StatelessWidget{
  const InputScreen({super.key});
  
  @override 
  Widget build(BuildContext context){
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        CarouselPageView(pageList:  <Widget>[
            BarcodeScannerPage()
          ])
        ],
    );
  }
}