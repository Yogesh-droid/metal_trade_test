import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageCubit extends Cubit<Locale> {
  ChangeLanguageCubit() : super(const Locale('en', 'US'));

  void changeLangue(Locale locale) {
    emit(locale);
  }
}
