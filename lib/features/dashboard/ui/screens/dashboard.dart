import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:metaltrade/features/enquiry/ui/screens/enquiry_page.dart';
import 'package:metaltrade/features/menu/ui/screens/menu_page.dart';
import 'package:metaltrade/features/network/ui/screens/network_page.dart';
import 'package:metaltrade/features/quotes/ui/screens/quote_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/strings.dart';
import '../../../home/ui/screens/home_page.dart';
import '../controllers/bottom_bar_controller_cubit.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getPages(),
      bottomNavigationBar: getBottomNavBar(),
    );
  }

  Widget getPages() {
    const List<Widget> pageList = [
      HomePage(),
      EnquiryPage(),
      QuotePage(),
      NetworkPage(),
      MenuPage()
    ];
    return BlocBuilder<BottomNavControllerCubit, int>(
        builder: (context, state) {
      return IndexedStack(
        index: state,
        children: pageList,
      );
    });
  }

  Widget getBottomNavBar() {
    return BlocBuilder<BottomNavControllerCubit, int>(
      builder: (context, state) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state,
            enableFeedback: true,
            selectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey[700],
            selectedLabelStyle: const TextStyle(color: Colors.black),
            unselectedLabelStyle: TextStyle(color: Colors.grey[600]),
            onTap: (value) {
              context.read<BottomNavControllerCubit>().changeIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon:
                      SvgPicture.asset(Assets.assetsBottomBarHome, height: 24),
                  activeIcon: SvgPicture.asset(Assets.assetsBottomBarHomeActive,
                      height: 24),
                  label: kHome),
              BottomNavigationBarItem(
                  icon:
                      SvgPicture.asset(Assets.assetsBottomBarNotes, height: 24),
                  activeIcon:
                      SvgPicture.asset(Assets.assetsBottomBarNotes, height: 24),
                  label: kEnquiry),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Assets.assetsBottomBarBag, height: 24),
                  activeIcon:
                      SvgPicture.asset(Assets.assetsBottomBarBag, height: 24),
                  label: kMyQuotes),
              BottomNavigationBarItem(
                  icon:
                      SvgPicture.asset(Assets.assetsBottomBarShare, height: 24),
                  activeIcon:
                      SvgPicture.asset(Assets.assetsBottomBarShare, height: 24),
                  label: kNetwork),
              BottomNavigationBarItem(
                  icon:
                      SvgPicture.asset(Assets.assetsBottomBarMenu, height: 24),
                  activeIcon: SvgPicture.asset(Assets.assetsBottomBarMenuActive,
                      height: 24),
                  label: kMenu),
            ]);
      },
    );
  }
}
