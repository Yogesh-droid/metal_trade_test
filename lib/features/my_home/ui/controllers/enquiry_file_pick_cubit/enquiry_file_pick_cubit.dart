import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

import '../../../../../core/resource/data_state/data_state.dart';

part 'enquiry_file_pick_state.dart';

class EnquiryFilePickCubit extends Cubit<EnquiryFilePickState> {
  final ChatFilePickUsecsse filePickUsecsse;
  EnquiryFilePickCubit(this.filePickUsecsse) : super(EnquiryFilePickInitial());

  Future<void> emitInitiaState() async {
    emit(EnquiryFilePickInitial());
  }

  Future<void> getImageFromLib(FileSource fileSource) async {
    emit(ENquiryFilePicking());
    try {
      DataState<File?> dataState =
          await filePickUsecsse.call(null, fileSource: fileSource);
      if (dataState.data != null) {
        emit(EnquiryFilePickSuccess(dataState.data!));
      } else {
        emit(EnquiryFilePickFailed(Exception("Something went wrong")));
      }
    } on Exception catch (e) {
      emit(EnquiryFilePickFailed(e));
    }
  }
}
