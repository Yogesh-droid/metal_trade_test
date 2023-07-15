import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/strings.dart';

List<NavigationDestination> destinations = const [
  NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: kHome),
  NavigationDestination(
      icon: Icon(Icons.description_outlined),
      selectedIcon: Icon(Icons.description),
      label: kEnquiry),
  NavigationDestination(
      icon: Icon(Icons.newspaper_outlined),
      selectedIcon: Icon(Icons.newspaper_rounded),
      label: kNews),
  NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline),
      selectedIcon: Icon(Icons.chat),
      label: kChat),
  NavigationDestination(
      icon: Icon(CupertinoIcons.person_alt_circle),
      selectedIcon: Icon(CupertinoIcons.person_alt_circle_fill),
      label: kMyProfile),
];
