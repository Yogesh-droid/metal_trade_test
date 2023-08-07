import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeLangauge extends StatelessWidget {
  ChangeLangauge({super.key});
  final List<String> languages = ["Hindi", "English"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
