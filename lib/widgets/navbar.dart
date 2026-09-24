import 'package:flutter/material.dart';
import 'package:scanner_app/state_management/tabs_controller.dart';

class Navbar extends StatelessWidget{
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = TabsController.of(context);
    return NavigationBar(
      selectedIndex: tabs.selectedIndex,
      onDestinationSelected: tabs.goTo,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.input), label: 'Input Screen'),
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.cloud), label: 'Connections')
      ]
    );
  }
}