import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../domain/repo/add_member_repo.dart';

class AddMemberRepoImpl implements AddMemberRepo {
  final NetworkManager networkManager;
  Response? response;
  AddMemberRepoImpl(this.networkManager);
  @override
  Future<DataState<bool>> addMember(RequestParams requestParams) async {
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return const DataSuccess(data: true);
      } else {
        return DataError(exception: Exception(response!.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
