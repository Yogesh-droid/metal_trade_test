import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_response_entity.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_list_repo.dart';

class ChatListUsecase extends Usecase {
  final ChatListRepo chatListRepo;

  ChatListUsecase({required this.chatListRepo});
  @override
  Future<DataState<ChatResponseEntity>> call(params) async {
    return await chatListRepo.getChatList(params);
  }
}
