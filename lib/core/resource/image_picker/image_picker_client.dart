import 'package:image_picker/image_picker.dart';

class ImagePickerClient {
  static final ImagePickerClient instance = ImagePickerClient._internal();
  final ImagePicker imagePicker = ImagePicker();

  factory ImagePickerClient() {
    return instance;
  }

  ImagePickerClient._internal();
}
