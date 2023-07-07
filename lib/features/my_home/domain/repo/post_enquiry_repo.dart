import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../entities/post_enquiry_res_entity.dart';

abstract class PostEnquiryRepo {
  Future<DataState<PostEnquiryResEntity>> postEnquiry(
      RequestParams requestParams);
}
