import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/my_home/data/models/post_enquiry_req_model.dart';
import 'package:metaltrade/features/rfq/data/models/submit_quote_model.dart';
import 'package:metaltrade/features/rfq/domain/usecases/submit_quote_usecase.dart';
part 'submit_quote_event.dart';
part 'submit_quote_state.dart';

class SubmitQuoteBloc extends Bloc<SubmitQuoteEvent, SubmitQuoteState> {
  final SubmitQuoteUsecase submitQuoteUsecase;
  SubmitQuoteBloc({required this.submitQuoteUsecase})
      : super(SubmitQuoteInitial()) {
    on<SubmitQuoteEvent>((event, emit) async {
      if (event is SubmitQuote) {
        final Map<String, dynamic> body = event.postEnquiryModel.toJson();
        try {
          emit(SubmittingQuote());
          final DataState<SubmitQuoteModel> dataState =
              await submitQuoteUsecase.call(RequestParams(
                  url: "${baseUrl}user/enquiry/${event.quoteId}/quote",
                  apiMethods: ApiMethods.post,
                  body: body,
                  header: header));

          if (dataState.data != null) {
            emit(SubmitQuoteSuccessful(submitQuoteModel: dataState.data!));
          } else {
            emit(SubmitQuoteFailed(exception: dataState.exception!));
          }
        } on Exception catch (e) {
          emit(SubmitQuoteFailed(exception: e));
        }
      }
    });
  }
}
