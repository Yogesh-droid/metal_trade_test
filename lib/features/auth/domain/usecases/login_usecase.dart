import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/auth/domain/repo/login_repo.dart';

class LoginUsecase extends Usecase {
  final LoginRepo loginRepo;

  LoginUsecase({required this.loginRepo});
  @override
  Future<DataState<String>> call(params) async {
    return await loginRepo.getOtp(params: params);
  }
}
