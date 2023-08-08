import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/domain/repo/download_file_repo.dart';

class DownloadFileRepoImpl implements DownloadFileRepo {
  final NetworkManager networkManager;

  DownloadFileRepoImpl(this.networkManager);
  @override
  Future<DataState<List<int>>> downloadFile(RequestParams params,
      {Function(int)? onReceiveProgress, Function(int)? onSendProgress}) async {
    try {
      Response? response;
      response = await networkManager.makeNetworkRequest(params,
          onReceiveProgress: onReceiveProgress);
      if (response!.data != null) {
        return DataSuccess(data: utf8.encode(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
