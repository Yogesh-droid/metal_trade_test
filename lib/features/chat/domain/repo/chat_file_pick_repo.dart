import 'dart:io';

import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

abstract class ChatFilePickRepo {
  Future<DataState<File?>> getImage({FileSource? fileSource});
}
