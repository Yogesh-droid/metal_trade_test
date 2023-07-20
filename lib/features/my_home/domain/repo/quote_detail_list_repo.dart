import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../rfq/domain/entities/rfq_enquiry_entity.dart';

abstract class QuoteDetailListRepo {
  Future<DataState<RfqEntity>> getQuoteDEtailList(RequestParams params);
}
