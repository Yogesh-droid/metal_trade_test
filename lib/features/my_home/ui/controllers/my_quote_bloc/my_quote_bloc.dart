import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/rfq/domain/usecases/rfq_usecase.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../../../rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';

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
          emit(MyQuoteInitial());
          final DataState<RfqEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry?page=${event.page}&size=10&enquiryType=${event.intent.name}$statusQuery",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            if (event.intent == UserIntent.Sell) {
              isMyQuoteListEnd = dataState.data!.last!;
              myQuoteListPage = (dataState.data!.number)! + 1;
              myQuoteList.addAll(dataState.data!.content!);
              emit(MyQuoteFetchedState(contentList: myQuoteList));
            }
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
