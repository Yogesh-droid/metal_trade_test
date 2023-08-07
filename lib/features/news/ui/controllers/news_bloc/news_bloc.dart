import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/news/domain/entities/news_entity.dart';
import '../../../data/models/news_model.dart';
import '../../../domain/usecases/news_usecase.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewUsecase newUsecase;
  List<News> newsList = [];
  int newsListPage = 0;
  bool isNewsListEnd = false;
  NewsBloc({required this.newUsecase}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetAllNewsEvent) {
        try {
          if (event.page == 0) {
            emit(NewsInitial());
          }
          if (event.page == newsListPage) {
            newsList.clear();
          }
          DataState<NewsEntity> dataState = await newUsecase.call(RequestParams(
              url:
                  "${baseUrl}user/news?page=${event.page}&size=12&future=${event.filters}",
              apiMethods: ApiMethods.get,
              header: header));
          if (dataState.data != null) {
            isNewsListEnd = dataState.data!.last!;
            newsListPage = dataState.data!.number!;
            newsList.addAll(dataState.data!.news!);
            emit(NewsFetched(newsList));
          } else {
            emit(NewsFailed(Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(NewsFailed(e));
        }
      }
    });
  }
}
