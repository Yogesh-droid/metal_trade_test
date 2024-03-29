import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/rfq/domain/entities/rfq_enquiry_entity.dart';
import 'package:metaltrade/features/rfq/domain/repo/rfq_enquiry_repo.dart';

class RfqUsecase extends Usecase {
  final RfqEnquiryRepo rfqRepo;

  RfqUsecase({required this.rfqRepo});
  @override
  Future<DataState<RfqEntity>> call(params) async {
    return await rfqRepo.getHomePageEnquiries(params);
  }
}
