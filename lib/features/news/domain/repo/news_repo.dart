import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/news/domain/entities/news_entity.dart';

import '../../../../core/resource/data_state/data_state.dart';

abstract class NewsRepo {
  Future<DataState<NewsEntity>> getNews(RequestParams params);
}
