import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/repo/delete_acc_repo.dart';

class DeleteAccountUsecase extends Usecase {
  final DeleteAccountRepo deleteAccountRepo;

  DeleteAccountUsecase(this.deleteAccountRepo);
  @override
  Future<DataState<bool>> call(params) async {
    return deleteAccountRepo.deleteAccount(params);
  }
}
