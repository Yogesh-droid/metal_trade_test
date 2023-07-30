import 'package:image_picker/image_picker.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';

abstract class ChatFilePickRepo {
  Future<DataState<XFile?>> getImage();
}
