import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

part 'chat_file_pick_state.dart';

class ChatFilePickCubit extends Cubit<ChatFilePickState> {
  final ChatFilePickUsecsse chatFilePickUsecsse;

  ChatFilePickCubit(this.chatFilePickUsecsse) : super(ChatFilePickInitial());

  Future<void> emitInitiaState() async {
    emit(ChatFilePickInitial());
  }

  Future<void> getImageFromLib() async {
    emit(ChatFilePicking());
    try {
      DataState<XFile?> dataState = await chatFilePickUsecsse.call(null);
      if (dataState.data != null) {
        XFile file = dataState.data!;
        emit(ChatFilePickSuccess(File(file.path)));
      } else {
        emit(ChatFilePickFailed(Exception("Something went wrong")));
      }
    } on Exception catch (e) {
      emit(ChatFilePickFailed(e));
    }
  }
}
