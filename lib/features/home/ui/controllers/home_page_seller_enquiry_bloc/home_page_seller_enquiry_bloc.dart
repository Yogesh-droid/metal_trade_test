import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../data/models/home_page_enquiry_model.dart';
import '../../../domain/entities/home_page_enquiry_entity.dart';
import '../../../domain/usecases/home_page_enquiry_usecase.dart';
import '../home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
part 'home_page_seller_enquiry_event.dart';
part 'home_page_seller_enquiry_state.dart';

class HomePageSellerEnquiryBloc
    extends Bloc<HomePageSellerEnquiryEvent, HomePageSellerEnquiryState> {
  bool isSellerListEnd = false;
  int sellerListPage = 0;
  List<Content> sellerEnquiryList = [];
  final HomePageEnquiryUsecase homePageEnquiryUsecase;
  HomePageSellerEnquiryBloc({required this.homePageEnquiryUsecase})
      : super(HomePageSellerEnquiryInitial()) {
    on<HomePageSellerEnquiryEvent>((event, emit) async {
      if (event is GetHomePageSellerEnquiryEvent) {
        try {
          final DataState<HomePageEnquiryEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry/all?page=${event.page}&size=20&enquiryType=${event.intent.name}",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            isSellerListEnd = dataState.data!.last!;
            sellerListPage = (dataState.data!.number)! + 1;
            sellerEnquiryList.addAll(dataState.data!.content!);
            emit(HomePageSellerEnquiryFetchedState(
                sellerEnquiryList: sellerEnquiryList));
          } else {
            emit(HoemPageSellerEnquiryFailed(
                exception: Exception("Data Not found")));
          }
        } on Exception catch (e) {
          emit(HoemPageSellerEnquiryFailed(exception: e));
        }
      }
    });
  }
}
