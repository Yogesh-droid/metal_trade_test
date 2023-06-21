import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/quotes/domain/entities/quote_res_entity.dart';
import 'package:metaltrade/features/quotes/domain/repo/quote_repo.dart';

class QuoteUsecase extends Usecase {
  final QuoteRepo quoteRepo;

  QuoteUsecase({required this.quoteRepo});
  @override
  Future<DataState<QuoteResEntity>> call(params) async {
    return quoteRepo.getQuoteList(requestParams: params);
  }
}
