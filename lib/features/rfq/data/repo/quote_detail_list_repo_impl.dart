import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import '../../../my_home/domain/repo/quote_detail_list_repo.dart';

class QuoteDetailListRepoImpl implements QuoteDetailListRepo {
  final NetworkManager networkManager;

  QuoteDetailListRepoImpl({required this.networkManager});
  @override
  Future<DataState<RfqEntity>> getQuoteDEtailList(RequestParams params) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(params);
      if (response!.data != null) {
        final value = RfqEnquiryModel.fromJson(response.data);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
