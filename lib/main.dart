import 'package:flutter/material.dart';
import 'package:scanner_app/screens/connections_screen.dart';
import 'package:scanner_app/screens/home_screen.dart';
import 'package:scanner_app/screens/input_screen.dart';
import 'package:scanner_app/state_management/tabs_controller.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  late int _pageIndex;

  @override
  void initState()
  {
    super.initState();
    _pageIndex=0;
  }

  static const List<Widget> _pages =[
    InputScreen(),
    HomeScreen(),
    ConnectionsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return TabsController(
      selectedIndex: _pageIndex,
      goTo: (i) => setState(() => _pageIndex = i),
      child: IndexedStack(
        index:_pageIndex, children: _pages
      )
    );
  }

  void changeIndex(int index)
  {
    _pageIndex=index;
  }
}
