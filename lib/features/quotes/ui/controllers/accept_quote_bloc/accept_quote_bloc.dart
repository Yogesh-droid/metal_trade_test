import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/quotes/domain/entities/accept_quote_res_entity.dart';
import '../../../domain/usecases/accept_quote_res_usecase.dart';
part 'accept_quote_event.dart';
part 'accept_quote_state.dart';

class AcceptQuoteBloc extends Bloc<AcceptQuoteEvent, AcceptQuoteState> {
  final AcceptQuoteResUsecase accetpQuoteUsecase;
  AcceptQuoteBloc(this.accetpQuoteUsecase) : super(AcceptQuoteInitial()) {
    on<AcceptQuoteEvent>((event, emit) async {
      if (event is QuoteAcceptEvent) {
        try {
          final DataState<AcceptQuoteResEntity> dataState =
              await accetpQuoteUsecase.call(RequestParams(
                  url: "${baseUrl}user/quote/${event.quoteId}",
                  apiMethods: ApiMethods.put,
                  body: {'status': event.status},
                  header: header));

          if (dataState.data != null) {
            emit(AcceptQuoteSuccessful(dataState.data!));
          } else {
            emit(AcceptQuoteFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(AcceptQuoteFailed(e));
        }
      }
      if (event is QuoteCancelEvent) {
        try {
          final DataState<AcceptQuoteResEntity> dataState =
              await accetpQuoteUsecase.call(RequestParams(
                  url: "${baseUrl}user/quote/${event.quoteId}",
                  apiMethods: ApiMethods.put,
                  body: {'status': event.status},
                  header: header));

          if (dataState.data != null) {
            emit(QuoteCancelledSuccess());
          } else {
            emit(QuoteCancelFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(QuoteCancelFailed(e));
        }
      }
    });
  }
}
