import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/widgets/language_selector.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.home),),
      body: Column(
        children: [
          Center(child: LanguageSelector()),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
