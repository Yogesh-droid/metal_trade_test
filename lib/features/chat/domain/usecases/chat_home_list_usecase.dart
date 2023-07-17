import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_list_entity.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_home_list_repo.dart';

class ChatHomeListUsecase extends Usecase {
  final ChatHomeListRepo chatHomeListRepo;

  ChatHomeListUsecase({required this.chatHomeListRepo});
  @override
  Future<DataState<ChatListEntity>> call(params) async {
    return await chatHomeListRepo.getChatHomeList(params);
  }
}
