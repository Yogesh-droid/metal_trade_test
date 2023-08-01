import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/data/models/profile_model.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/get_all_employee_repo.dart';

class GetAllEmployeeRepoImpl implements GetAllEmployeeRepo {
  final NetworkManager networkManager;

  GetAllEmployeeRepoImpl({required this.networkManager});
  @override
  Future<DataState<List<ProfileEntity>>> getAllEmployee(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        List<ProfileEntity> list = [];
        for (var element in response.data['content']) {
          list.add(ProfileModel.fromJson(element));
        }
        return DataSuccess(data: list);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
