import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/my_home/domain/repo/update_rfq_repo.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

class UpdateMyRfqRepoImpl implements UpdateRfqRepo {
  final NetworkManager networkManager;
  UpdateMyRfqRepoImpl(this.networkManager);

  @override
  Future<DataState<Content>> updateMyRfq(RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(data: Content.fromJson(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
