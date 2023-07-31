import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

abstract class ChatFileUploadRepo {
  Future<DataState<String>> uploadFile(RequestParams params,
      {Function(int)? onReceiveProgress, Function(int)? onSendProgress});
}
