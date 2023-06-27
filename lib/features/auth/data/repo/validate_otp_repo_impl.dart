import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/auth/domain/repo/validate_otp_repo.dart';

class ValidateOtpRepoImpl implements ValidateOtpRepo {
  final NetworkManager networkManager;

  ValidateOtpRepoImpl({required this.networkManager});
  @override
  Future<DataState<String>> validateOtp({required RequestParams params}) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(params);
      if (response!.data != null) {
        return DataSuccess(data: response.data);
      } else {
        return DataError(exception: Exception("No data found"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e));
    }
  }
}
