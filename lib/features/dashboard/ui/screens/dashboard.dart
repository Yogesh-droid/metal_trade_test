import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/chat/ui/screens/chat_home_page.dart';
import 'package:metaltrade/features/dashboard/ui/widgets/destinations.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_home_page.dart';
import 'package:metaltrade/features/profile/ui/screens/profile_screen.dart';
import 'package:metaltrade/features/rfq/ui/screens/rfq_home_page.dart';
import '../../../news/ui/screens/news_page.dart';
import '../controllers/bottom_bar_controller_cubit.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        body: getPages(),
        bottomNavigationBar: getBottomNavBar());
  }

  Widget getPages() {
    const List<Widget> pageList = [
      MyHomePage(),
      RfqHomePage(),
      NewsPage(),
      ChatHomePage(),
      ProfileScreen()
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
        return NavigationBar(
          destinations: destinations,
          selectedIndex: state,
          indicatorColor:
              Theme.of(context).colorScheme.inversePrimary.withOpacity(0.50),
          onDestinationSelected: (value) {
            context.read<BottomNavControllerCubit>().changeIndex(value);
          },
        );
      },
    );
  }
}
