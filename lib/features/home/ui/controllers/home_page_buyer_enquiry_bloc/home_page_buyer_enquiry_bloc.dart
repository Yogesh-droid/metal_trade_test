import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';
import '../../../data/models/home_page_enquiry_model.dart';
import '../../../domain/entities/home_page_enquiry_entity.dart';
part 'home_page_buyer_enquiry_event.dart';
part 'home_page_buyer_enquiry_state.dart';

class HomePageBuyerEnquiryBloc
    extends Bloc<HomePageEnquiryEvent, HomePageBuyerEnquiryState> {
  final HomePageEnquiryUsecase homePageEnquiryUsecase;
  List<Content> buyerEnquiryList = [];
  int buyerListPage = 0;
  bool isBuyerListEnd = false;
  HomePageBuyerEnquiryBloc({required this.homePageEnquiryUsecase})
      : super(HomePageBuyerEnquiryInitial()) {
    on<HomePageEnquiryEvent>((event, emit) async {
      if (event is GetHomeBuyerPageEnquiryEvent) {
        try {
          emit(HomePageBuyerEnquiryInitial());
          final DataState<HomePageEnquiryEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry/all?page=${event.page}&size=20&enquiryType=${event.intent.name}",
                  apiMethods: ApiMethods.get,
                  header: header));

          if (dataState.data != null) {
            if (event.intent == UserIntent.Buy) {
              isBuyerListEnd = dataState.data!.last!;
              buyerListPage = (dataState.data!.number)! + 1;
              buyerEnquiryList.addAll(dataState.data!.content!);
              emit(HomePageBuyerEnquiryFetchedState(
                  buyerEnquiryList: buyerEnquiryList));
            }
          } else {
            emit(HoemPageBuyerEnquiryFailed(
                exception: Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(HoemPageBuyerEnquiryFailed(exception: e));
        }
      }
    });
  }
}
