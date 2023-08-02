import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class DeleteEmpRepo {
  Future<DataState<String>> deleteEmployee(RequestParams params);
}
