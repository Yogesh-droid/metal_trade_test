import 'package:dio/dio.dart';
import 'package:metaltrade/core/resource/network/network_manager.dart';
import 'package:metaltrade/features/news/data/models/news_model.dart';
import 'package:metaltrade/features/news/domain/entities/news_entity.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/news/domain/repo/news_repo.dart';

class NewsRepoImpl implements NewsRepo {
  final NetworkManager networkManager;

  NewsRepoImpl({required this.networkManager});
  @override
  Future<DataState<NewsEntity>> getNews(RequestParams params) async {
    Response? response;
    try {
      response = await networkManager.makeNetworkRequest(params);
      if (response!.data != null) {
        return DataSuccess(data: NewsModel.fromJson(response.data));
      } else {
        return DataError(exception: Exception(response.statusMessage));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
