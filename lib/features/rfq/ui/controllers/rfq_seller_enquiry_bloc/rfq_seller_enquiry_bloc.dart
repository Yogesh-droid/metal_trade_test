import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../data/models/rfq_enquiry_model.dart';
import '../../../domain/entities/rfq_enquiry_entity.dart';
import '../../../domain/usecases/rfq_usecase.dart';
import '../rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
part 'rfq_seller_enquiry_event.dart';
part 'rfq_seller_enquiry_state.dart';

class RfqSellerEnquiryBloc
    extends Bloc<RfqSellerEnquiryEvent, RfqSellerEnquiryState> {
  bool isSellerRfqListEnd = false;
  int sellerRfqListPage = 0;
  List<Content> sellerRfqList = [];
  final RfqUsecase homePageEnquiryUsecase;
  RfqSellerEnquiryBloc({required this.homePageEnquiryUsecase})
      : super(RfqSellerEnquiryInitial()) {
    on<RfqSellerEnquiryEvent>((event, emit) async {
      if (event is GetRfqSellerEnquiryEvent) {
        try {
          if (sellerRfqListPage == 0) {
            emit(RfqSellerEnquiryInitial());
          } else {
            emit(RfqSellerEnquiryLoadMore());
          }
          final DataState<RfqEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry/all?page=${event.page}&size=5&enquiryType=${event.intent.name}",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            isSellerRfqListEnd = dataState.data!.last!;
            sellerRfqListPage = (dataState.data!.number)! + 1;
            sellerRfqList.addAll(dataState.data!.content!);
            emit(RfqSellerEnquiryFetchedState(sellerRfqList: sellerRfqList));
          } else {
            emit(RfqSellerEnquiryFailed(
                exception: Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(RfqSellerEnquiryFailed(exception: e));
        }
      }
    });
  }
}
