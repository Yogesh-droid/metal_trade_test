import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBtnCubit extends Cubit<bool> {
  ChatBtnCubit() : super(false);

  void changeState(bool active) {
    emit(active);
  }
}
