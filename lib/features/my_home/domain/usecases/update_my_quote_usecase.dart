import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/my_home/domain/repo/update_my_quote_repo.dart';

import '../../../../core/resource/data_state/data_state.dart';
import '../../../rfq/data/models/rfq_enquiry_model.dart';

class UpdateMyQuoteUsecase extends Usecase {
  final UpdateMyQuoteRepo updateMyQuoteRepo;

  UpdateMyQuoteUsecase(this.updateMyQuoteRepo);
  @override
  Future<DataState<Content>> call(params) async {
    return updateMyQuoteRepo.updateMyQuote(params);
  }
}
