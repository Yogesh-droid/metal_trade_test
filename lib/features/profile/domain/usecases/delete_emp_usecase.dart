import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/repo/delete_employee_repo.dart';

import '../../../../core/resource/data_state/data_state.dart';

class DeleteEmpUsecase extends Usecase {
  final DeleteEmpRepo deleteEmpRepo;

  DeleteEmpUsecase(this.deleteEmpRepo);
  @override
  Future<DataState<String>> call(params) async {
    return await deleteEmpRepo.deleteEmployee(params);
  }
}
