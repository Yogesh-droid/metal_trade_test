import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import '../../../../chat/domain/usecases/chat_file_upload_usecase.dart';
import '../../../data/models/post_enquiry_req_model.dart';
import '../../../domain/entities/post_enquiry_res_entity.dart';
import '../../../domain/usecases/post_enquiry_usecase.dart';
part 'create_enquiry_event.dart';
part 'create_enquiry_state.dart';

class CreateEnquiryBloc extends Bloc<CreateEnquiryEvent, CreateEnquiryState> {
  final PostEnquiryUsecase postEnquiryUsecase;
  final ChatFileUploadUsecase chatFileUploadUsecase;
  String? url = '';

  CreateEnquiryBloc(
      {required this.postEnquiryUsecase, required this.chatFileUploadUsecase})
      : super(CreateEnquiryInitial()) {
    on<CreateEnquiryEvent>((event, emit) async {
      if (event is PostEnquiryEvent) {
        emit(PostEnquiryInProgress());
        Map<String, dynamic> body = event.postEnquiryModel.toJson();
        try {
          DataState<PostEnquiryResEntity> dataState =
              await postEnquiryUsecase.call(RequestParams(
                  url: "${baseUrl}user/enquiry",
                  apiMethods: ApiMethods.post,
                  body: body,
                  header: header));

          if (dataState.data != null) {
            emit(PostEnquirySuccessful(dataState.data!));
          } else {
            emit(PostEnquiryFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(PostEnquiryFailed(e));
        }
      }
      if (event is UploadEnquiryAttachment) {
        try {
          DataState<String> dataState = await chatFileUploadUsecase.call(
              RequestParams(
                  url: "${baseUrl}user/file/upload",
                  apiMethods: ApiMethods.multipart,
                  fileName: event.filaName,
                  filePath: event.filePath,
                  header: header), onSendProgress: (value) {
            emit(EnquiryFileUploading(value));
          });

          if (dataState.data != null) {
            url = dataState.data!;
            emit(EnquiryFileUploadSuccess(dataState.data!));
          } else {
            log(dataState.exception.toString());
            emit(EnquiryFileUploadFailed(Exception("Something went wrong")));
          }
        } on Exception catch (e) {
          log(e.toString());
          emit(EnquiryFileUploadFailed(e));
        }
      }
    });
  }
}
