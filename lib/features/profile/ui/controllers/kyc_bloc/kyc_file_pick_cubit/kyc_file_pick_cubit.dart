import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';
part 'kyc_file_pick_state.dart';

class KycFilePickCubit extends Cubit<KycFilePickState> {
  final ChatFilePickUsecsse chatFilePickUsecsse;
  List<File> fileList = [];
  KycFilePickCubit(this.chatFilePickUsecsse) : super(KycFilePickInitial());

  Future<void> emitInitiaState() async {
    emit(KycFilePickInitial());
  }

  Future<void> pickFile() async {
    emit(KycFilePicking());
    try {
      DataState<XFile?> dataState = await chatFilePickUsecsse.call(null);
      if (dataState.data != null) {
        XFile file = dataState.data!;
        fileList.add(File(file.path));
        emit(KycFilePickSuccess(fileList));
      } else {
        emit(KycFilePickeFailed(Exception("Something went wrong")));
      }
    } on Exception catch (e) {
      emit(KycFilePickeFailed(e));
    }
  }

  Future<void> pickMoreFiles() async {}
}
