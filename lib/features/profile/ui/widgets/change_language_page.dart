import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/profile/ui/controllers/change_language_cubit/change_language_cubit.dart';

class ChangeLangauge extends StatelessWidget {
  ChangeLangauge({super.key});
  final Map<String, String> language = {"Hindi": "hi", "English": "en"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextMenuAppBar(title: kChangeLanguage),
      body: BlocBuilder<ChangeLanguageCubit, String>(
        builder: (context, state) {
          return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: language.keys.length,
              itemBuilder: (context, index) => RadioListTile(
                  value: language.values.toList()[index],
                  groupValue: state,
                  title: Text(language.keys.toList()[index]),
                  onChanged: (value) {
                    context
                        .read<ChangeLanguageCubit>()
                        .changeLangue(value.toString());
                  }));
        },
      ),
    );
  }
}
