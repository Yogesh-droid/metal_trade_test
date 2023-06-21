import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/features/quotes/data/models/quote_res_model.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/quotes/domain/entities/quote_res_entity.dart';
import 'package:metaltrade/features/quotes/domain/repo/quote_repo.dart';

class QuoteRepoImpl implements QuoteRepo {
  final NetworkManager networkManager;

  QuoteRepoImpl({required this.networkManager});
  @override
  Future<DataState<QuoteResEntity>> getQuoteList(
      {required RequestParams requestParams}) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        return DataSuccess(
            data: QuoteResModel.fromJson(jsonDecode(response.data)));
      } else {
        return DataError(exception: Exception("No Data found"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
