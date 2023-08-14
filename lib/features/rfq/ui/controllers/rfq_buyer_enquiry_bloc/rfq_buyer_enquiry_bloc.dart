import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import '../../../data/models/rfq_enquiry_model.dart';
import '../../../domain/entities/rfq_enquiry_entity.dart';
import '../../../domain/usecases/rfq_usecase.dart';
part 'rfq_buyer_enquiry_event.dart';
part 'rfq_buyer_enquiry_state.dart';

class RfqBuyerEnquiryBloc extends Bloc<RfqEnquiryEvent, RfqBuyerEnquiryState> {
  final RfqUsecase homePageEnquiryUsecase;
  List<Content> buyerRfqList = [];
  int buyerRfqListPage = 0;
  bool isBuyerRfqListEnd = false;
  RfqBuyerEnquiryBloc({required this.homePageEnquiryUsecase})
      : super(RfqBuyerEnquiryInitial()) {
    on<RfqEnquiryEvent>((event, emit) async {
      if (event is GetRfqBuyerPageEnquiryEvent) {
        try {
          if (event.page == 0) {
            buyerRfqList.clear();
            emit(RfqBuyerEnquiryInitial());
          } else {
            emit(RfqBuyerEnquiryLoadMore());
          }
          final DataState<RfqEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry/all?page=${event.page}&size=5&enquiryType=${event.intent.name}&text=${event.text ?? ''}",
                  apiMethods: ApiMethods.get,
                  header: header));

          if (dataState.data != null) {
            if (event.intent == UserIntent.Buy) {
              isBuyerRfqListEnd = dataState.data!.last!;
              buyerRfqListPage = (dataState.data!.number)! + 1;
              buyerRfqList.addAll(dataState.data!.content!);
              emit(RfqBuyerEnquiryFetchedState(buyerEnquiryList: buyerRfqList));
            }
          } else {
            emit(RfqBuyerEnquiryFailed(
                exception: Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(RfqBuyerEnquiryFailed(exception: e));
        }
      }
    });
  }
}
