import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/rfq/domain/usecases/rfq_usecase.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../../rfq/data/models/rfq_enquiry_model.dart';

part 'my_quote_event.dart';
part 'my_quote_state.dart';

class MyQuoteBloc extends Bloc<MyQuoteEvent, MyQuoteState> {
  final RfqUsecase homePageEnquiryUsecase;
  List<Content> myQuoteList = [];
  int myQuoteListPage = 0;
  bool isMyQuoteListEnd = false;
  MyQuoteBloc({required this.homePageEnquiryUsecase})
      : super(MyQuoteInitial()) {
    on<MyQuoteEvent>((event, emit) async {
      if (event is GetQuoteList) {
        String statusQuery = event.status.isNotEmpty
            ? "&status=${event.status.join('&status=')}"
            : '';
        try {
          if (event.page == 0) {
            emit(MyQuoteInitial());
          }
          if (event.page == myQuoteListPage) {
            myQuoteList.clear();
          }
          if (event.isLoadMore) {
            emit(MyQuoteLoadMore());
          }
          final DataState<RfqEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/quote?page=${event.page}&size=10$statusQuery",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            isMyQuoteListEnd = dataState.data!.last!;
            myQuoteListPage = (dataState.data!.number)!;
            myQuoteList.addAll(dataState.data!.content!);
            emit(MyQuoteFetchedState(contentList: myQuoteList));
          } else {
            emit(MyQuoteFailedState(exception: Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(MyQuoteFailedState(exception: e));
        }
      }
    });
  }
}
