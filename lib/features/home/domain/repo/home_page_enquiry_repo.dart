import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/home/domain/entities/home_page_enquiry_entity.dart';

abstract class HomePageEnquiryRepo {
  Future<DataState<HomePageEnquiryEntity>> getHomePageEnquiries(
      RequestParams requestParams);
}
