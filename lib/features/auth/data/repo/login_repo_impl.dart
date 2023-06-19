import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/auth/domain/repo/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final NetworkManager networkManager;

  LoginRepoImpl({required this.networkManager});
  @override
  Future<DataState<String>> getOtp({required RequestParams params}) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(params);
      if (response!.data != null) {
        final value = response.data;
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
