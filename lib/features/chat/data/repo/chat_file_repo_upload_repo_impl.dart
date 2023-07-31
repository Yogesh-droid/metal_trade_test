import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_file_upload_repo.dart';

class ChatFileUploadRepoImpl implements ChatFileUploadRepo {
  final NetworkManager networkManager;
  Response? response;

  ChatFileUploadRepoImpl(this.networkManager);
  @override
  Future<DataState<String>> uploadFile(RequestParams params,
      {Function(int)? onReceiveProgress, Function(int)? onSendProgress}) async {
    try {
      response = await networkManager.makeNetworkRequest(params,
          onReceiveProgress: onReceiveProgress, onsendProgress: onSendProgress);
      if (response!.data != null) {
        return DataSuccess(data: response!.data!);
      } else {
        return DataError(exception: Exception(response!.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
