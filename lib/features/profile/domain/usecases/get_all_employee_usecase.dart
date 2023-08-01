import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/get_all_employee_repo.dart';

class GetAllEmployeeUsecase extends Usecase {
  final GetAllEmployeeRepo getAllEmployeeRepo;

  GetAllEmployeeUsecase({required this.getAllEmployeeRepo});
  @override
  Future<DataState<List<ProfileEntity>>> call(params) async {
    return await getAllEmployeeRepo.getAllEmployee(params);
  }
}
