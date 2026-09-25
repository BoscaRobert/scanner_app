  import 'package:flutter/material.dart';
  import 'package:mobile_scanner/mobile_scanner.dart';

  class DialogBuilder {
    static Widget buildDialog(
      BuildContext context,
      BarcodeCapture result,
      Future<void> Function() accept,
      VoidCallback reject,
      String message,
    ) {
      return AlertDialog(
        title: Text('Scan result'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              reject();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async{
              await accept();
              if(context.mounted){
                Navigator.of(context).pop();
              }
            },
            child: const Text('Accept'),
          ),
        ],
      );
    }
  }