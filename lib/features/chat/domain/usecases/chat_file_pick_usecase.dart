import 'dart:io';

import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_file_pick_repo.dart';

import '../../../../core/usecase/usecase.dart';

enum FileSource { gallery, camera, files }

class ChatFilePickUsecase extends Usecase {
  final ChatFilePickRepo chatFilePickRepo;
  ChatFilePickUsecase(this.chatFilePickRepo);
  @override
  Future<DataState<File?>> call(params, {FileSource? fileSource}) async {
    return await chatFilePickRepo.getImage(fileSource: fileSource);
  }
}
