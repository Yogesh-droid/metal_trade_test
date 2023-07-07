import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/rfq/domain/usecases/rfq_usecase.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../../rfq/data/models/rfq_enquiry_model.dart';
import '../../../../rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
part 'my_rfq_state.dart';
part 'my_rfq_event.dart';

class MyRfqBloc extends Bloc<MyRfqEvent, MyRfqState> {
  final RfqUsecase homePageEnquiryUsecase;
  List<Content> myRfqList = [];
  int myRfqListPage = 0;
  bool isMyRfqListEnd = false;
  MyRfqBloc({required this.homePageEnquiryUsecase}) : super(MyRfqInitial()) {
    on<MyRfqEvent>((event, emit) async {
      if (event is GetMyRfqList) {
        String statusQuery = event.status.isNotEmpty
            ? "&status=${event.status.join('&status=')}"
            : '';
        try {
          emit(MyRfqInitial());
          final DataState<RfqEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry?page=${event.page}&size=10&enquiryType=${event.intent.name}$statusQuery",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            if (event.intent == UserIntent.Buy) {
              isMyRfqListEnd = dataState.data!.last!;
              myRfqListPage = (dataState.data!.number)! + 1;
              myRfqList.addAll(dataState.data!.content!);
              emit(MyRfqFetchedState(contentList: myRfqList));
            }
          } else {
            emit(MyRfqFailedState(exception: Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(MyRfqFailedState(exception: e));
        }
      }
    });
  }
}
