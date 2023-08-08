import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../rfq/data/models/rfq_enquiry_model.dart';

abstract class UpdateMyQuoteRepo {
  Future<DataState<Content>> updateMyQuote(RequestParams params);
}
