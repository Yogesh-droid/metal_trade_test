import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

import '../../../../../core/resource/data_state/data_state.dart';

part 'enquiry_file_pick_state.dart';

class EnquiryFilePickCubit extends Cubit<EnquiryFilePickState> {
  final ChatFilePickUsecase filePickUsecase;
  EnquiryFilePickCubit(this.filePickUsecase) : super(EnquiryFilePickInitial());

  Future<void> emitInitialState() async {
    emit(EnquiryFilePickInitial());
  }

  Future<void> getImageFromLib(FileSource fileSource) async {
    emit(EnquiryFilePicking());
    try {
      DataState<File?> dataState =
          await filePickUsecase.call(null, fileSource: fileSource);
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
