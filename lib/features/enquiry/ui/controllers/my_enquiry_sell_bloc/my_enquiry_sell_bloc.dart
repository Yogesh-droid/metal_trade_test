import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../../home/data/models/home_page_enquiry_model.dart';
import '../../../../home/domain/entities/home_page_enquiry_entity.dart';
import '../../../../home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';

part 'my_enquiry_sell_event.dart';
part 'my_enquiry_sell_state.dart';

class MyEnquirySellBloc extends Bloc<MyEnquirySellEvent, MyEnquirySellState> {
  final HomePageEnquiryUsecase homePageEnquiryUsecase;
  List<Content> myEnquirySellList = [];
  int myEnquirySellListPage = 0;
  bool isMyEnquirySellListEnd = false;
  MyEnquirySellBloc({required this.homePageEnquiryUsecase})
      : super(MyEnquirySellInitial()) {
    on<MyEnquirySellEvent>((event, emit) async {
      if (event is GetMyEnquirySellList) {
        String statusQuery = event.status.isNotEmpty
            ? "&status=${event.status.join('&status=')}"
            : '';
        try {
          emit(MyEnquirySellInitial());
          final DataState<HomePageEnquiryEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry?page=${event.page}&size=10&enquiryType=${event.intent.name}$statusQuery",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            if (event.intent == UserIntent.Sell) {
              isMyEnquirySellListEnd = dataState.data!.last!;
              myEnquirySellListPage = (dataState.data!.number)! + 1;
              myEnquirySellList.addAll(dataState.data!.content!);
              emit(MyEnquirySellFetchedState(contentList: myEnquirySellList));
            }
          } else {
            emit(MyEnquirySellFailedState(
                exception: Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(MyEnquirySellFailedState(exception: e));
        }
      }
    });
  }
}
