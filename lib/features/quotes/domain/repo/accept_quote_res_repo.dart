import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/quotes/domain/entities/accept_quote_res_entity.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class AcceptQuoteResRepo {
  Future<DataState<AcceptQuoteResEntity>> acceptQuote(
      RequestParams requestParams);
}
