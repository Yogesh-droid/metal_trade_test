import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/repo/add_member_repo.dart';

class AddMemberUsecase extends Usecase {
  final AddMemberRepo addMemberRepo;

  AddMemberUsecase(this.addMemberRepo);
  @override
  Future<DataState<bool>> call(params) async {
    return await addMemberRepo.addMember(params);
  }
}
