import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/domain/usecases/update_rfq_usecase.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/rfq/domain/usecases/rfq_usecase.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/resource/data_state/data_state.dart';
import '../../../../../core/resource/request_params/request_params.dart';
import '../../../../rfq/data/models/rfq_enquiry_model.dart';
part 'my_rfq_state.dart';
part 'my_rfq_event.dart';

class MyRfqBloc extends Bloc<MyRfqEvent, MyRfqState> {
  final RfqUsecase homePageEnquiryUsecase;
  final UpdateRfqUsecase updateRfqUsecase;
  List<Content> myRfqList = [];
  int myRfqListPage = 0;
  bool isMyRfqListEnd = false;
  MyRfqBloc(
      {required this.updateRfqUsecase, required this.homePageEnquiryUsecase})
      : super(MyRfqInitial()) {
    on<MyRfqEvent>((event, emit) async {
      if (event is GetMyRfqList) {
        String statusQuery = event.status != null
            ? event.status!.isNotEmpty
                ? "&status=${event.status!.join('&status=')}"
                : ''
            : '';
        try {
          if (event.page == 0) {
            emit(MyRfqInitial());
          }
          if (event.page == myRfqListPage) {
            myRfqList.clear();
          }
          if (event.isLoadMore) {
            emit(MyRfqLoadMore());
          }
          final DataState<RfqEntity> dataState =
              await homePageEnquiryUsecase.call(RequestParams(
                  url:
                      "${baseUrl}user/enquiry?page=${event.page}&size=5$statusQuery",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            isMyRfqListEnd = dataState.data!.last!;
            myRfqListPage = (dataState.data!.number)!;
            myRfqList.addAll(dataState.data!.content!);
            emit(MyRfqFetchedState(contentList: myRfqList));
          } else {
            emit(MyRfqFailedState(exception: Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(MyRfqFailedState(exception: e));
        }
      }
      if (event is UpdateMyRfq) {
        try {
          DataState<Content> dataState = await updateRfqUsecase.call(
              RequestParams(
                  url: "${baseUrl}user/enquiry/${event.id}",
                  apiMethods: ApiMethods.put,
                  body: {"status": event.status},
                  header: header));
          if (dataState.data != null) {
            for (var element in myRfqList) {
              if (event.id == element.id) {
                element.status = dataState.data!.status;
              }
            }
            emit(MyRfqFetchedState(contentList: myRfqList));
          } else {
            UpdateRfqFailed(Exception(dataState.exception));
          }
          emit(MyRfqFetchedState(contentList: myRfqList));
        } on Exception catch (e) {
          emit(UpdateRfqFailed(e));
        }
      }
    });
  }
}
