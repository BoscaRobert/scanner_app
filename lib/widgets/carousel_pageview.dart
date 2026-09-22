import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarouselPageView extends StatefulWidget{
  const CarouselPageView({super.key,required this.pageList});
  final List<Widget> pageList;
  @override
  State<CarouselPageView> createState() => _CareouselPageViewState();

}

class _CareouselPageViewState extends State<CarouselPageView> with TickerProviderStateMixin{

  late List<Widget> _pageList;
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  @override
  void initState()
  {
    super.initState();
    _pageList = widget.pageList;
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .bottomCenter,
      children: <Widget>[
        PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: _pageController,
          onPageChanged: _handlePageViewChanged,
          children: _pageList,
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currentPageIndex,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          isOnDesktopAndWeb: _isOnDesktopAndWeb,
        ),
      ],
    );
  }

   void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        .macOS || .linux || .windows => true,
        .android || .iOS || .fuchsia => false,
      };
}


class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const .all(8.0),
      child: Row(
        mainAxisAlignment: .center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: .zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(Icons.arrow_left_rounded, size: 32.0),
          ),
          TabPageSelector(
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: .zero,
            onPressed: () {
              if (currentPageIndex == 2) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(Icons.arrow_right_rounded, size: 32.0),
          ),
        ],
      ),
    );
  }
}