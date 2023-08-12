import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/profile/ui/controllers/change_language_cubit/change_language_cubit.dart';

class ChangeLangauge extends StatelessWidget {
  ChangeLangauge({super.key});
  final List<Locale> language = [
    const Locale('hi', 'IN'),
    const Locale('en', 'US'),
    const Locale('zh', 'CN')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextMenuAppBar(title: kChangeLanguage),
      body: BlocConsumer<ChangeLanguageCubit, Locale>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("Language changed Successfully")));
        },
        builder: (context, state) {
          return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: language.length,
              itemBuilder: (context, index) => RadioListTile<Locale>(
                  value: language[index],
                  groupValue: state,
                  title: Text(language[index].languageCode),
                  onChanged: (value) {
                    context.setLocale(value!);
                    context.read<ChangeLanguageCubit>().changeLangue(value);
                  }));
        },
      ),
    );
  }
}
