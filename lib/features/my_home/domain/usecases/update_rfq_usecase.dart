import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/my_home/domain/repo/update_rfq_repo.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';

class UpdateRfqUsecase extends Usecase {
  final UpdateRfqRepo updateRfqRepo;

  UpdateRfqUsecase(this.updateRfqRepo);
  @override
  Future<DataState<Content>> call(params) async {
    return updateRfqRepo.updateMyRfq(params);
  }
}
