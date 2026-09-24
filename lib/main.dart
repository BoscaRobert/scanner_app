import 'package:flutter/material.dart';
import 'package:scanner_app/l10n/app_localizations.dart';
import 'package:scanner_app/screens/connections_screen.dart';
import 'package:scanner_app/screens/home_screen.dart';
import 'package:scanner_app/screens/input_screen.dart';
import 'package:scanner_app/state_management/tabs_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scanner_app/persistance/locale_persistance.dart';
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
  _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
  state?.setState(() {
    state._locale = newLocale;
  });
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState()
  {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final saved = await LocaleService.load();
    if (!mounted) return;
    setState(() => _locale = saved);
  }

  Future<void> changeLocale(Locale? newLocale) async {
    setState(() => _locale = newLocale);
    await LocaleService.save(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      home: const Main(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
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
