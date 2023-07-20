import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/data/models/submit_quote_model.dart';
import '../../../rfq/domain/repo/submit_quote_repo.dart';

class SubmitQuoteRepoImpl implements SubmitQuoteRepo {
  final NetworkManager networkManager;

  SubmitQuoteRepoImpl({required this.networkManager});
  @override
  Future<DataState<SubmitQuoteModel>> submitQuote(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        final value = SubmitQuoteModel.fromJson(response.data);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
