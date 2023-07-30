import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/image_picker/image_picker_client.dart';

class ImagePickerManager {
  final ImagePicker imagePickerClient = ImagePickerClient().imagePicker;

  Future<XFile?> pickImageFromGallery() {
    try {
      return imagePickerClient.pickImage(source: ImageSource.gallery);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<XFile?> pickImageFromCamera() {
    return imagePickerClient.pickImage(source: ImageSource.camera);
  }

  Future<List<XFile>> pickMultipleImages() {
    return imagePickerClient.pickMultiImage();
  }
}
