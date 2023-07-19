import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/rfq/domain/usecases/quote_detail_list_usecase.dart';

part 'quote_detail_list_event.dart';
part 'quote_detail_list_state.dart';

class QuoteDetailListBloc
    extends Bloc<QuoteDetailListEvent, QuoteDetailListState> {
  final QuoteDetailListUsecase quoteDetailListUsecase;
  List<Content> contentList = [];
  int quoteListPage = 0;
  bool isQuoteListEnd = false;
  QuoteDetailListBloc(this.quoteDetailListUsecase)
      : super(QuoteDetailListInitial()) {
    on<QuoteDetailListEvent>((event, emit) async {
      if (event is GetQuoteDetailList) {
        try {
          if (event.page == quoteListPage) {
            contentList.clear();
          }
          if (event.page == 0) {
            emit(QuoteDetailListInitial());
          }
          if (event.isLoadMore) {
            emit(QuoteDetailListLoadMore());
          }
          DataState<RfqEntity> dataState = await quoteDetailListUsecase.call(
              RequestParams(
                  url:
                      "${baseUrl}user/enquiry/${event.enquiryId}/quote?page=${event.page}&size=20",
                  apiMethods: ApiMethods.get,
                  header: header));

          if (dataState.data != null) {
            contentList.addAll(dataState.data!.content!);
            quoteListPage = dataState.data!.number!;
            isQuoteListEnd = dataState.data!.last!;
            emit(QuoteDetailListSuccess(contentList: contentList));
          } else {
            emit(QuoteDetailListFailed(dataState.exception!));
          }
        } on Exception catch (e) {
          emit(QuoteDetailListFailed(e));
        }
      }
    });
  }
}
