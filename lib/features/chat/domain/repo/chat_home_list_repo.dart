import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_list_entity.dart';

abstract class ChatHomeListRepo {
  Future<DataState<ChatListEntity>> getChatHomeList(
      RequestParams requestParams);
}
