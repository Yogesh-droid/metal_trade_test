import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metaltrade/core/constants/assets.dart';
import '../../../../core/constants/strings.dart';

List<NavigationDestination> destinations = [
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardHome),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardHomeActive),
      label: kHome),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardRFQs),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardRFQsActive),
      label: kEnquiry),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardMarketNews),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardMarketNewsActive),
      label: kNews),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardChat),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardChatActive),
      label: kChat),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardProfile),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardProfileActive),
      label: kMyProfile),
];
