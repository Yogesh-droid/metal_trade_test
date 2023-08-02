import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/repo/delete_employee_repo.dart';

class DeleteEmpRepoImpl implements DeleteEmpRepo {
  final NetworkManager networkManager;

  DeleteEmpRepoImpl(this.networkManager);
  @override
  Future<DataState<String>> deleteEmployee(RequestParams params) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(params);
      if (response!.data != null) {
        return DataSuccess(data: response.data);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
