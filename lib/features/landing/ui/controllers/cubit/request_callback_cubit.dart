import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/landing/domain/entities/request_callback_entity.dart';
import 'package:metaltrade/features/landing/domain/usecases/request_callback_usecase.dart';

part 'request_callback_state.dart';

class RequestCallbackCubit extends Cubit<RequestCallbackState> {
  final RequestCallbackUsecase requestCallbackUsecase;
  RequestCallbackCubit(this.requestCallbackUsecase)
      : super(RequestCallbackInitial());
  Future<void> requestCallback(Map<String, dynamic> requestBody) async {
    try {
      emit(RequestCallbackLoading());
      final DataState<RequestCallbackEntity> dataState =
          await requestCallbackUsecase.call(RequestParams(
              url: "${baseUrl}callback",
              apiMethods: ApiMethods.post,
              body: requestBody,
              header: header));

      if (dataState.data != null) {
        emit(RequestCallbackSuccess(dataState.data!));
      } else {
        emit(RequestCallbackFailed(dataState.exception!));
      }
    } on Exception catch (e) {
      emit(RequestCallbackFailed(e));
    }
  }
}
