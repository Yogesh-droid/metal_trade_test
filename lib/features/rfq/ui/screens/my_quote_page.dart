import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/my_home/ui/screens/my_quote_screen.dart';

class MyQuotesPage extends StatelessWidget {
  const MyQuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ContextMenuAppBar(title: kMyQuotes),
      body: MyQuoteScreen(),
    );
  }
}
