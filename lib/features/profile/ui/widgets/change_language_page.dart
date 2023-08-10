import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';

class ChangeLanguage extends StatelessWidget {
  ChangeLanguage({super.key});
  final List<String> languages = [
    "Bahasa Indonesia",
    "Chinese",
    "English",
    "Hindi",
    "Malay Malaysia",
    "Spanish",
    "Thai",
    "Vietnamese"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextMenuAppBar(title: kChangeLanguage),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(languages[index]),
          onTap: () {
            if (languages[index] == "Hindi") {
              context.setLocale(const Locale('hi', 'IN'));
            } else {
              context.setLocale(const Locale('en', 'US'));
            }
          },
        ),
      ),
    );
  }
}
