import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/rfq/domain/repo/download_file_repo.dart';

class DownloadFileUsecase extends Usecase {
  final DownloadFileRepo downloadFileRepo;

  DownloadFileUsecase({required this.downloadFileRepo});
  @override
  Future<DataState<List<int>>> call(params,
      {Function(int)? onReceiveProgress}) async {
    return downloadFileRepo.downloadFile(params,
        onReceiveProgress: onReceiveProgress);
  }
}
