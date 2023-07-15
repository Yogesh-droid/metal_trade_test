import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/data/models/submit_quote_model.dart';

abstract class SubmitQuoteRepo {
  Future<DataState<SubmitQuoteModel>> submitQuote(RequestParams requestParams);
}
