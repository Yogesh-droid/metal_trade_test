import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/repo/delete_acc_repo.dart';

class DeleteAccRepoImpl implements DeleteAccountRepo {
  final NetworkManager networkManager;

  DeleteAccRepoImpl(this.networkManager);
  @override
  Future<DataState<bool>> deleteAccount(RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return const DataSuccess(data: true);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e));
    }
  }
}
