import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_file_pick_repo.dart';

import '../../../../core/usecase/usecase.dart';

class ChatFilePickUsecsse extends Usecase {
  final ChatFilePickRepo chatFilePickRepo;

  ChatFilePickUsecsse(this.chatFilePickRepo);
  @override
  Future<DataState<XFile?>> call(params) async {
    return await chatFilePickRepo.getImage();
  }
}
