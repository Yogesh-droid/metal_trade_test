import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/domain/usecases/download_file_usecase.dart';
import 'package:path_provider/path_provider.dart';
part 'download_file_state.dart';

class DownloadFileCubit extends Cubit<DownloadFileState> {
  final DownloadFileUsecase downloadFileUsecase;
  DownloadFileCubit(this.downloadFileUsecase) : super(DownloadFileInitial());

  void emitIntial() {
    emit(DownloadFileInitial());
  }

  Future<void> downloadFile(String url) async {
    try {
      DataState<List<int>> dataState = await downloadFileUsecase
          .call(RequestParams(url: url, apiMethods: ApiMethods.get),
              onReceiveProgress: (value) {
        emit(FileDownloading(value));
      });
      if (dataState.data != null) {
        saveFile(data: dataState.data, url: url);
        emit(DownloadFileSuccess(true));
      } else {
        emit(FileDownloadFailed(Exception(dataState.exception)));
      }
    } on Exception catch (e) {
      emit(FileDownloadFailed(e));
    }
  }

  Future<void> saveFile({List<int>? data, String? url}) async {
    final dir = Directory(
        '${(Platform.isAndroid ? "/storage/emulated/0/Download" //FOR ANDROID
            : await getApplicationSupportDirectory() //FOR IOS
        )}/Metaltrade');
    if (!await dir.exists()) {
      dir.create();
    }
    String fullPath = "${dir.path}/${url!.split(RegExp(r'[/_-]')).last}";
    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(data!);
    await raf.close();
  }
}
