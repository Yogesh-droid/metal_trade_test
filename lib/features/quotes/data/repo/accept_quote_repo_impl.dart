import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/features/quotes/data/models/quote_res_model.dart';
import 'package:metaltrade/features/quotes/domain/entities/accept_quote_res_entity.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/quotes/domain/repo/accept_quote_res_repo.dart';

class AcceptQuoteRepoImpl implements AcceptQuoteResRepo {
  final NetworkManager networkManager;

  AcceptQuoteRepoImpl(this.networkManager);
  @override
  Future<DataState<AcceptQuoteResEntity>> acceptQuote(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(data: Content.fromJson(response.data));
      } else {
        return DataError(exception: Exception("No data found"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
