import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../../home/data/models/home_page_enquiry_model.dart';
import '../../../../home/domain/entities/home_page_enquiry_entity.dart';
import '../../../../home/ui/controllers/home_page_buyer_enquiry_bloc/home_page_buyer_enquiry_bloc.dart';
part 'my_enquiry_buy_state.dart';
part 'my_enquiry_buy_event.dart';

class MyEnquiryBloc extends Bloc<MyEnquiryEvent, MyEnquiryState> {
  final HomePageEnquiryUsecase homePageEnquiryUsecase;
  List<Content> myEnquiryList = [];
  int myEnquiryListPage = 0;
  bool isMyEnquiryListEnd = false;
  MyEnquiryBloc({required this.homePageEnquiryUsecase})
      : super(MyEnquiryInitial()) {
    on<MyEnquiryEvent>((event, emit) async {
      if (event is GetMyEnquiryList) {
        String statusQuery = event.status.isNotEmpty
            ? "&status=${event.status.join('&status=')}"
            : '';
        try {
          emit(MyEnquiryInitial());
          final DataState<HomePageEnquiryEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry?page=${event.page}&size=10&enquiryType=${event.intent.name}$statusQuery",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            if (event.intent == UserIntent.Buy) {
              isMyEnquiryListEnd = dataState.data!.last!;
              myEnquiryListPage = (dataState.data!.number)! + 1;
              myEnquiryList.addAll(dataState.data!.content!);
              emit(MyEnquiryFetchedState(contentList: myEnquiryList));
            }
          } else {
            emit(MyEnquiryFailedState(exception: Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(MyEnquiryFailedState(exception: e));
        }
      }
    });
  }
}
