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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<BottomNavControllerCubit>().changeIndex(2);
          },
          backgroundColor: blue,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.home_filled,
            color: white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getPages() {
    const List<Widget> pageList = [
      MenuPage(),
      EnquiryPage(),
      HomePage(),
      QuotePage(),
      NetworkPage(),
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
            selectedItemColor: blue,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey[700],
            selectedLabelStyle: const TextStyle(color: blue),
            unselectedLabelStyle: TextStyle(color: Colors.grey[600]),
            onTap: (value) {
              context.read<BottomNavControllerCubit>().changeIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_outlined),
                  activeIcon: Icon(Icons.newspaper_rounded),
                  label: kNews),
              BottomNavigationBarItem(
                  icon: Icon(Icons.description_outlined),
                  activeIcon: Icon(Icons.description),
                  label: kEnquiry),
              BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 24,
                  ),
                  label: kHome),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall_outlined),
                  activeIcon: Icon(Icons.local_mall),
                  label: kMyQuotes),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  activeIcon: Icon(Icons.chat),
                  label: kChat),
            ]);
      },
    );
  }
}
