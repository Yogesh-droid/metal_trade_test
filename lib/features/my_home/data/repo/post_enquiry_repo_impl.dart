import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import '../../domain/entities/post_enquiry_res_entity.dart';
import '../../domain/repo/post_enquiry_repo.dart';
import '../models/post_enquiry_res_model.dart';

class PostEnquiryRepoImpl extends PostEnquiryRepo {
  final NetworkManager networkManager;

  PostEnquiryRepoImpl({required this.networkManager});
  @override
  Future<DataState<PostEnquiryResEntity>> postEnquiry(
      RequestParams requestParams) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(requestParams);
      if (response!.statusCode == 200) {
        final value = PostEnquiryResModel.fromJson(response.data);
        return DataSuccess(data: value);
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
