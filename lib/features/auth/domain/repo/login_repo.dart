import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class LoginRepo {
  Future<DataState<String>> getOtp({required RequestParams params});
}
