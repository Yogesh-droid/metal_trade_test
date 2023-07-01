import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/kyc_repo.dart';

class KycUsecase extends Usecase {
  final KycRepo kycRepo;

  KycUsecase({required this.kycRepo});
  @override
  Future<DataState<ProfileEntity>> call(params) async {
    return await kycRepo.doKyc(params);
  }
}
