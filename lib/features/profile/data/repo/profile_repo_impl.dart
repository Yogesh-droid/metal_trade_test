import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/features/profile/data/models/profile_model.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/profile/domain/repo/get_profile_repo.dart';

class ProfileRepoImpl implements GetProfileRepo {
  final NetworkManager networkManager;

  ProfileRepoImpl(this.networkManager);
  @override
  Future<DataState<ProfileEntity>> getProfile(RequestParams params) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(params);
      if (response!.data != null) {
        return DataSuccess(data: ProfileModel.fromJson(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
