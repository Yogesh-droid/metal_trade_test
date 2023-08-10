import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageCubit extends Cubit<String> {
  ChangeLanguageCubit() : super('en');

  void changeLangue(String langCode) {
    emit(langCode);
  }
}
