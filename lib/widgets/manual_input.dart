import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'package:scanner_app/networking/connection.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/widgets/snack_bar_message.dart';

class ManualInputPage extends StatefulWidget{
  const ManualInputPage({super.key});

  @override
  State<ManualInputPage> createState() => _ManualInputPageState();
}

class _ManualInputPageState extends State<ManualInputPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Input"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                bool result=await ServerConnection.sendIdToServer(_controller.text);
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
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      bottomNavigationBar:Navbar()
    );
  }
}