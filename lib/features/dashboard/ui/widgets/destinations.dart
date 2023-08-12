import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metaltrade/core/constants/assets.dart';
import '../../../../core/constants/strings.dart';

List<NavigationDestination> destinations = [
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardHome),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardHomeActive),
      label: kHome.tr()),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardRFQs),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardRFQsActive),
      label: kEnquiry.tr()),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardMarketNews),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardMarketNewsActive),
      label: kNews.tr()),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardChat),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardChatActive),
      label: kChat.tr()),
  NavigationDestination(
      icon: SvgPicture.asset(Assets.assetsDashboardProfile),
      selectedIcon: SvgPicture.asset(Assets.assetsDashboardProfileActive),
      label: kMyProfile.tr()),
];
