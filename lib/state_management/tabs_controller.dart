import 'package:flutter/material.dart';

class TabsController extends InheritedWidget {
  const TabsController({
    super.key,
    required this.selectedIndex,
    required this.goTo,
    required super.child,
  });

  final int selectedIndex;
  final ValueChanged<int> goTo;

  static TabsController of(BuildContext context) {
    final c = context.dependOnInheritedWidgetOfExactType<TabsController>();
    assert(c != null, 'No TabsController above this widget');
    return c!;
  }

  @override
  bool updateShouldNotify(TabsController old) =>
      selectedIndex != old.selectedIndex;
}