import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_response_entity.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_list_repo.dart';

class ChatListRepoImpl implements ChatListRepo {
  final NetworkManager networkManager;

  ChatListRepoImpl({required this.networkManager});
  @override
  Future<DataState<ChatResponseEntity>> getChatList(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(data: ChatResponseModel.fromJson(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
