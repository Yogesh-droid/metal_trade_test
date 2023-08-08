import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/image_picker/image_picker_manager.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_file_pick_repo.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_pick_usecase.dart';

class ChatFilePickRepoImpl implements ChatFilePickRepo {
  final ImagePickerManager imagePickerManager;
  XFile? xFile;
  ChatFilePickRepoImpl(this.imagePickerManager);

  @override
  Future<DataState<File?>> getImage({FileSource? fileSource}) async {
    if (fileSource != null) {
      switch (fileSource) {
        case FileSource.camera:
          xFile = await imagePickerManager.pickImageFromCamera();
          if (xFile != null) {
            return DataSuccess(data: File(xFile!.path));
          } else {
            throw Exception('No File Selected');
          }
        case FileSource.gallery:
          xFile = await imagePickerManager.pickImageFromGallery();
          if (xFile != null) {
            return DataSuccess(data: File(xFile!.path));
          } else {
            throw Exception('No File Selected');
          }
        default:
          File file = await imagePickerManager.pickFileFromFiles();
          return DataSuccess(data: file);
      }
    } else {
      return DataError(exception: Exception("Something went wrong"));
    }
    // try {
    //   if (xFile != null) {
    //     return DataSuccess(data: File(xFile!.path));
    //   }
    // } on Exception catch (e) {
    //   return DataError(exception: e);
    // }
  }
}
