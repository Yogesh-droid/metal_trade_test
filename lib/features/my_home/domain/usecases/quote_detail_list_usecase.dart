import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/my_home/domain/repo/quote_detail_list_repo.dart';

class QuoteDetailListUsecase extends Usecase {
  final QuoteDetailListRepo quoteDetailListRepo;

  QuoteDetailListUsecase({required this.quoteDetailListRepo});
  @override
  Future<DataState<RfqEntity>> call(params) async {
    return await quoteDetailListRepo.getQuoteDEtailList(params);
  }
}
