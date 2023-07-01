import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/entities/country_entity.dart';

abstract class CountryRepo {
  Future<DataState<List<CountryEntity>>> getCountryList(
      RequestParams requestParams);
}
