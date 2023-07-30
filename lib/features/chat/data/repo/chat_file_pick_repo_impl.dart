import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/image_picker/image_picker_manager.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_file_pick_repo.dart';

class ChatFilePickRepoImpl implements ChatFilePickRepo {
  final ImagePickerManager imagePickerManager;
  XFile? xFile;
  ChatFilePickRepoImpl(this.imagePickerManager);

  @override
  Future<DataState<XFile?>> getImage() async {
    xFile = await imagePickerManager.pickImageFromGallery();
    try {
      if (xFile != null) {
        return DataSuccess(data: xFile);
      } else {
        return DataError(exception: Exception("Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
