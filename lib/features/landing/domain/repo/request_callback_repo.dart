import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/landing/domain/entities/request_callback_entity.dart';

abstract class RequestCallbackRepo {
  Future<DataState<RequestCallbackEntity>> getCallBack(
      RequestParams requestParams);
}
