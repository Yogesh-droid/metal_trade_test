import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/data/models/country_model.dart';
import 'package:metaltrade/features/profile/domain/entities/country_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/country_repo.dart';

class CountryRepoImpl implements CountryRepo {
  final NetworkManager networkManager;

  CountryRepoImpl({required this.networkManager});
  @override
  Future<DataState<List<CountryEntity>>> getCountryList(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        final List<CountryModel> list = [];
        for (var element in response.data) {
          list.add(CountryModel.fromJson(element));
        }
        return DataSuccess(data: list);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
