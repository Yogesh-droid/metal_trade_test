import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';

abstract class GetAllEmployeeRepo {
  Future<DataState<List<ProfileEntity>>> getAllEmployee(
      RequestParams requestParams);
}
