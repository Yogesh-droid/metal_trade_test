import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/data/models/chat_list_model.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_list_entity.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_home_list_repo.dart';

class ChatHomeListRepoImpl implements ChatHomeListRepo {
  final NetworkManager networkManager;

  ChatHomeListRepoImpl({required this.networkManager});
  @override
  Future<DataState<ChatListEntity>> getChatHomeList(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        final value = ChatListModel.fromJson(response.data);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
