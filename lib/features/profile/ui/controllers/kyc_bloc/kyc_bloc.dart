import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_upload_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/kyc_usecase.dart';
import '../../../data/models/kyc_request_model.dart';
import '../../../domain/entities/profile_entity.dart';
part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final KycUsecase kycUsecase;
  final ChatFileUploadUsecase chatFileUploadUsecase;
  List<String> url = [];
  KycBloc(this.kycUsecase, this.chatFileUploadUsecase) : super(KycInitial()) {
    on<KycEvent>((event, emit) async {
      if (event is DoKycEvent) {
        try {
          final DataState<ProfileEntity> dataState = await kycUsecase.call(
              RequestParams(
                  url: "${baseUrl}user",
                  apiMethods: ApiMethods.post,
                  header: header,
                  body: event.kycRequestModel.toJson()));
          if (dataState.data != null) {
            emit(KycDoneState(dataState.data!));
          } else {
            emit(KycFailedState(dataState.exception!));
          }
        } on Exception catch (e) {
          emit(KycFailedState(e));
        }
      }

      if (event is UploadKycDoc) {
        try {
          DataState<String> dataState = await chatFileUploadUsecase.call(
              RequestParams(
                  url: "${baseUrl}user/file/upload",
                  apiMethods: ApiMethods.multipart,
                  fileName: event.fileName,
                  filePath: event.filePath,
                  header: header), onSendProgress: (value) {
            emit(KycFileUploading(value));
          });

          if (dataState.data != null) {
            url.add(dataState.data!);
            emit(KycFIleUploadSuccess(url));
          } else {
            log(dataState.exception.toString());
            emit(KycFileUploadFailed(Exception("Something went wrong")));
          }
        } on Exception catch (e) {
          log(e.toString());
          emit(KycFileUploadFailed(e));
        }
      }
      if (event is RemoveKycDoc) {
        url.removeAt(event.index);
        emit(KycFIleUploadSuccess(url));
      }
      if (event is AddUserDoc) {
        url.clear();
        url.addAll(event.urlList);
        emit(KycFIleUploadSuccess(url));
      }
      if (event is EmitInitialKycState) {
        emit(KycInitial());
      }
    });
  }
}
