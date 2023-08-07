import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  Future<File> pickFileFromFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        throw Exception("No File picked");
      }
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
