import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

abstract class DeleteAccountRepo {
  Future<DataState<bool>> deleteAccount(RequestParams requestParams);
}
