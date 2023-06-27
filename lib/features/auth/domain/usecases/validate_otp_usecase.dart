import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/auth/domain/repo/validate_otp_repo.dart';

class ValidateOtpUsecase extends Usecase {
  final ValidateOtpRepo validateOtpRepo;

  ValidateOtpUsecase({required this.validateOtpRepo});
  @override
  Future<DataState<String>> call(params) {
    return validateOtpRepo.validateOtp(params: params);
  }
}
