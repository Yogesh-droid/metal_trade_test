import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/data/models/my_order_model.dart';
import 'package:metaltrade/features/profile/domain/entities/my_order_entity.dart';
import 'package:metaltrade/features/profile/domain/usecases/my_order_usecase.dart';
part 'my_order_event.dart';
part 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  final MyOrderUsecase myOrderUsecase;
  int myOrderPage = 0;
  List<Content> myOrderList = [];
  bool? isMyOrderListEnd = false;
  MyOrderBloc(this.myOrderUsecase) : super(MyOrderInitial()) {
    on<MyOrderEvent>((event, emit) async {
      if (event is GetMyOrderEvent) {
        if (event.pageNo == 0) {
          emit(MyOrderInitial());
          myOrderList.clear();
        }
        if (event.isLoadMore) {
          emit(MyOrderLoading());
        }
        try {
          DataState<MyOrderEntity> dataState = await myOrderUsecase.call(
              RequestParams(
                  url: "${baseUrl}user/order?page=${event.pageNo}&size=10",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
            myOrderList.addAll(dataState.data!.content!);
            myOrderPage = dataState.data!.number!;
            isMyOrderListEnd = dataState.data!.last;
            emit(MyOrderSuccess(myOrderList));
          } else {
            emit(MyOrderFailed(exception: Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(MyOrderFailed(exception: e));
        }
      }
    });
  }
}
