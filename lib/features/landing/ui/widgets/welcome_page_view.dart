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
  late Timer timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
        setState(() {});
        print(_currentPage);
      } else {
        _currentPage = 0;
        setState(() {});
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_pageController.hasClients) {
        print(_currentPage);
        _pageController.animateToPage(_currentPage,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
      }
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
    return PageView.builder(
        key: const ValueKey("Pageview"),
        controller: _pageController,
        onPageChanged: (value) {},
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return widget.pages[index];
        });
  }
}
