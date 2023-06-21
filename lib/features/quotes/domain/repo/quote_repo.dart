import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import '../entities/quote_res_entity.dart';

abstract class QuoteRepo {
  Future<DataState<QuoteResEntity>> getQuoteList(
      {required RequestParams requestParams});
}
