import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/enquiry/domain/usecases/post_enquiry_usecase.dart';
import '../../../data/models/post_enquiry_model.dart';
import '../../../domain/entities/post_enquiry_res_entity.dart';
part 'create_enquiry_event.dart';
part 'create_enquiry_state.dart';

class CreateEnquiryBloc extends Bloc<CreateEnquiryEvent, CreateEnquiryState> {
  final PostEnquiryUsecase postEnquiryUsecase;
  CreateEnquiryBloc(this.postEnquiryUsecase) : super(CreateEnquiryInitial()) {
    on<CreateEnquiryEvent>((event, emit) async {
      if (event is PostEnquiryEvent) {
        Map<String, dynamic> body = event.postEnquiryModel.toJson();
        try {
          await postEnquiryUsecase.call(RequestParams(
              url: "${baseUrl}user/enquiry",
              apiMethods: ApiMethods.post,
              body: body,
              header: header));
        } on Exception catch (e) {
          emit(PostEnquiryFailed(e));
        }
      }
    });
  }
}
