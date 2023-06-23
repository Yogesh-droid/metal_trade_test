import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/quotes/domain/entities/accept_quote_res_entity.dart';
import 'package:metaltrade/features/quotes/domain/repo/accept_quote_res_repo.dart';

class AcceptQuoteResUsecase extends Usecase {
  final AcceptQuoteResRepo acceptQuoteResRepo;

  AcceptQuoteResUsecase({required this.acceptQuoteResRepo});
  @override
  Future<DataState<AcceptQuoteResEntity>> call(params) async {
    return await acceptQuoteResRepo.acceptQuote(params);
  }
}
