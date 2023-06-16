import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/features/home/data/models/home_page_enquiry_model.dart';
import 'package:metaltrade/features/home/domain/entities/home_page_enquiry_entity.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/home/domain/repo/home_page_enquiry_repo.dart';

class HomePageEnquiryImpl implements HomePageEnquiryRepo {
  final NetworkManager networkManager;

  HomePageEnquiryImpl({required this.networkManager});
  @override
  Future<DataState<HomePageEnquiryEntity>> getHomePageEnquiries(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.data != null) {
        final value = HomePageEnquiryModel.fromJson(response.data);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
