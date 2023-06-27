import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

abstract class ValidateOtpRepo {
  Future<DataState<String>> validateOtp({required RequestParams params});
}
