import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_file_upload_repo.dart';

class ChatFileUploadUsecase extends Usecase {
  final ChatFileUploadRepo chatFileUploadRepo;

  ChatFileUploadUsecase(this.chatFileUploadRepo);
  @override
  Future<DataState<String>> call(params,
      {Function(int)? onReceiveProgress, Function(int)? onSendProgress}) {
    return chatFileUploadRepo.uploadFile(params,
        onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
  }
}
