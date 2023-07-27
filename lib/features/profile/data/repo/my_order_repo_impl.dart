import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/data/models/my_order_model.dart';
import 'package:metaltrade/features/profile/domain/entities/my_order_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/my_order_repo.dart';

class MyOrderRepoImpl implements MyOrderRepo {
  final NetworkManager networkManager;

  MyOrderRepoImpl({required this.networkManager});
  @override
  Future<DataState<MyOrderEntity>> getMyOrder(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(data: MyOrderModel.fromJson(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on DioException catch (e) {
      return DataError(exception: e);
    }
  }
}
