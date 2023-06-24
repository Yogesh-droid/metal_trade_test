import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class GetProfileRepo {
  Future<DataState<ProfileEntity>> getProfile(RequestParams params);
}
