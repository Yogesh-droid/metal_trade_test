import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/rfq/data/models/submit_quote_model.dart';

import '../repo/submit_quote_repo.dart';

class SubmitQuoteUsecase extends Usecase {
  final SubmitQuoteRepo submitQuoteRepo;

  SubmitQuoteUsecase({required this.submitQuoteRepo});
  @override
  Future<DataState<SubmitQuoteModel>> call(params) async {
    return submitQuoteRepo.submitQuote(params);
  }
}
