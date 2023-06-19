import 'dart:async';

import 'package:flutter/material.dart';

class WelcomePageView extends StatefulWidget {
  const WelcomePageView({super.key, required this.pages});
  final List<Widget> pages;

  @override
  State<WelcomePageView> createState() => _WelcomePageViewState();
}

class _WelcomePageViewState extends State<WelcomePageView> {
  late PageController _pageController;
  List<Widget> newList = [];
  late Timer timer;
  int _currentPage = 0;
  bool _isReversed = false;

  @override
  void initState() {
    super.initState();
    newList.addAll(widget.pages);
    _pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _currentPage++;
      setState(() {});
      // if (_currentPage < newList.length - 1) {
      //   _currentPage++;
      //   _isReversed = false;
      //   setState(() {});
      //   print(_currentPage);
      // } else {
      //   _currentPage = 0;
      //   _isReversed = true;
      //   setState(() {});
      // }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController.animateToPage(_currentPage,
          duration: const Duration(seconds: 1), curve: Curves.easeIn);
    });
    return PageView.builder(
        key: const ValueKey("Pageview"),
        physics: const ClampingScrollPhysics(),
        allowImplicitScrolling: true,
        // reverse: _isReversed,
        controller: _pageController,
        onPageChanged: (value) {
          print("On Page chaned");
          _currentPage = value % newList.length;
          print("$_currentPage is on page page changed");
        },
        // itemCount: newList.length,
        itemBuilder: (context, index) {
          return newList[index % newList.length];
        });
  }
}
