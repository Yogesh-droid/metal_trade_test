import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/landing/data/models/request_callback_model.dart';
import 'package:metaltrade/features/landing/domain/entities/request_callback_entity.dart';
import 'package:metaltrade/features/landing/domain/repo/request_callback_repo.dart';

class RequestCallbackRepoImpl extends RequestCallbackRepo {
  final NetworkManager networkManager;

  RequestCallbackRepoImpl(this.networkManager);
  @override
  Future<DataState<RequestCallbackEntity>> getCallBack(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(data: RequestCallbackModel.fromJson(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on DioException catch (e) {
      return DataError(exception: e);
    }
  }
}
