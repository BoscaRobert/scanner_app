import 'package:flutter/material.dart';
import 'package:scanner_app/state_management/tabs_controller.dart';
import 'package:scanner_app/l10n/app_localizations.dart';

class Navbar extends StatelessWidget{
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tabs = TabsController.of(context);
    return NavigationBar(
      selectedIndex: tabs.selectedIndex,
      onDestinationSelected: tabs.goTo,
      destinations:[
        NavigationDestination(icon: Icon(Icons.input), label: l10n.inputScreen),
        NavigationDestination(icon: Icon(Icons.home), label: l10n.home),
        NavigationDestination(icon: Icon(Icons.storage), label: l10n.connections)
      ]
    );
  }
}