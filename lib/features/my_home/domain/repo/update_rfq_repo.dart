import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../../core/resource/data_state/data_state.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';

abstract class UpdateRfqRepo {
  Future<DataState<Content>> updateMyRfq(RequestParams requestParams);
}
