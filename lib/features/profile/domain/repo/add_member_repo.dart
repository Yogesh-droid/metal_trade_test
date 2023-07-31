import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

abstract class AddMemberRepo {
  Future<DataState<bool>> addMember(RequestParams requestParams);
}
