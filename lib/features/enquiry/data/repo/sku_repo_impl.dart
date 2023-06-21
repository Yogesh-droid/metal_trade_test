import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/features/enquiry/data/models/sku_model.dart';
import 'package:metaltrade/features/enquiry/domain/entities/sku_entity.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/enquiry/domain/repo/sku_repo.dart';

class SkuRepoImpl implements SkuRepo {
  final NetworkManager networkManager;

  SkuRepoImpl({required this.networkManager});
  @override
  Future<DataState<SkuEntity>> getSku(RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(data: SkuModel.fromJson(response.data));
      } else {
        return DataError(exception: Exception("No Data Found"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
