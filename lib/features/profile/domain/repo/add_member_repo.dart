import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../entities/profile_entity.dart';

abstract class AddMemberRepo {
  Future<DataState<ProfileEntity>> addMember(RequestParams requestParams);
}
