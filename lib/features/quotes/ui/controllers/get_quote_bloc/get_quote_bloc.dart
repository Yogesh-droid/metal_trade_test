import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/quotes/domain/entities/quote_res_entity.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../data/models/quote_res_model.dart';
import '../../../domain/usecases/quote_usecase.dart';
part 'get_quote_event.dart';
part 'get_quote_state.dart';

class GetQuoteBloc extends Bloc<GetQuoteEvent, GetQuoteState> {
  final QuoteUsecase quoteUsecase;
  List<Content> myQuoteList = [];
  int myQuoteListPage = 0;
  bool isMyQuoteListEnd = false;
  GetQuoteBloc({required this.quoteUsecase}) : super(GetQuoteInitial()) {
    on<GetQuoteEvent>((event, emit) async {
      if (event is GetAllQuoteEvent) {
        String statusQuery = event.statusList.isNotEmpty
            ? "&status=${event.statusList.join('&status=')}"
            : '';
        emit(GetQuoteInitial());
        try {
          final DataState<QuoteResEntity> dataState = await quoteUsecase.call(
              RequestParams(
                  url:
                      "${baseUrl}user/quote?page=${event.pageNo}&size=20$statusQuery",
                  apiMethods: ApiMethods.get));
          if (dataState.data != null) {
            isMyQuoteListEnd = dataState.data!.last!;
            myQuoteListPage = (dataState.data!.number)! + 1;
            myQuoteList.addAll(dataState.data!.content!);
            emit(GetAllQuoteFetched(quoteList: myQuoteList));
          } else {
            emit(GetQuoteFailedState(exception: Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(GetQuoteFailedState(exception: e));
        }
      }
    });
  }
}
