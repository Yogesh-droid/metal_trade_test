import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

abstract class DownloadFileRepo {
  Future<DataState<List<int>>> downloadFile(RequestParams params,
      {Function(int)? onReceiveProgress, Function(int)? onSendProgress});
}
