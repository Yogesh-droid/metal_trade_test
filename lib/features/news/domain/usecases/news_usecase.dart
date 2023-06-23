import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/news/domain/entities/news_entity.dart';
import 'package:metaltrade/features/news/domain/repo/news_repo.dart';

class NewUsecase extends Usecase {
  final NewsRepo newsRepo;

  NewUsecase({required this.newsRepo});
  @override
  Future<DataState<NewsEntity>> call(params) async {
    return await newsRepo.getNews(params);
  }
}
