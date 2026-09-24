import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/navbar.dart';

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
      appBar: AppBar(title:Text('Connections')),

      bottomNavigationBar: Navbar(),
    );
  }

}