import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';

abstract class RfqEnquiryRepo {
  Future<DataState<RfqEntity>> getHomePageEnquiries(
      RequestParams requestParams);
}
