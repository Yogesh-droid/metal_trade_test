import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

part 'kyc_file_pick_state.dart';

class KycFilePickCubit extends Cubit<KycFilePickState> {
  final ChatFilePickUsecase chatFilePickUsecase;
  KycFilePickCubit(this.chatFilePickUsecase) : super(KycFilePickInitial());

  Future<void> emitInitialState() async {
    emit(KycFilePickInitial());
  }

  Future<void> pickFile(FileSource fileSource) async {
    emit(KycFilePicking());
    try {
      DataState<File?> dataState =
          await chatFilePickUsecase.call(null, fileSource: fileSource);
      if (dataState.data != null) {
        emit(KycFilePickSuccess(dataState.data!));
      } else {
        emit(KycFilePickeFailed(Exception("Something went wrong")));
      }
    } on Exception catch (e) {
      emit(KycFilePickeFailed(e));
    }
  }

  Future<void> pickMoreFiles() async {}
}
