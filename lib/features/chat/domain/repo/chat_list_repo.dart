import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_response_entity.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class ChatListRepo {
  Future<DataState<ChatResponseEntity>> getChatList(
      RequestParams requestParams);
}
