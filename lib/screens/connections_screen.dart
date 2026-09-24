import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/navbar.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/networking/connection.dart';

class ConnectionsScreen extends StatefulWidget{
  const ConnectionsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ConnectionsScreenState();
  }
}

class _ConnectionsScreenState extends State<ConnectionsScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title:Text(AppLocalizations.of(context)!.connections)),
      body: FloatingActionButton(onPressed: () {ServerConnection.test();}),
      bottomNavigationBar: Navbar(),
    );
  }

}