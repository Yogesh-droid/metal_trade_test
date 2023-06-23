import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/news/domain/entities/news_entity.dart';
import '../../../data/models/news_model.dart';
import '../../../domain/usecases/news_usecase.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewUsecase newUsecase;
  NewsBloc({required this.newUsecase}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetAllNewsEvent) {
        try {
          DataState<NewsEntity> dataState = await newUsecase.call(RequestParams(
              url:
                  "user/news?page=${event.page}&size=12&future=${event.future}",
              apiMethods: ApiMethods.get));
          if (dataState.data != null) {
            emit(NewsFetched(dataState.data!.news!));
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
