import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

import '../../../../../core/resource/data_state/data_state.dart';

part 'enquiry_file_pick_state.dart';

class EnquiryFilePickCubit extends Cubit<EnquiryFilePickState> {
  final ChatFilePickUsecsse filePickUsecsse;
  EnquiryFilePickCubit(this.filePickUsecsse) : super(EnquiryFilePickInitial());

  Future<void> emitInitiaState() async {
    emit(EnquiryFilePickInitial());
  }

  Future<void> getImageFromLib() async {
    emit(ENquiryFilePicking());
    try {
      DataState<XFile?> dataState = await filePickUsecsse.call(null);
      if (dataState.data != null) {
        XFile file = dataState.data!;
        emit(EnquiryFilePickSuccess(File(file.path)));
      } else {
        emit(EnquiryFilePickFailed(Exception("Something went wrong")));
      }
    } on Exception catch (e) {
      emit(EnquiryFilePickFailed(e));
    }
  }
}
