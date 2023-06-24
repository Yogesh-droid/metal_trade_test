import 'package:metaltrade/core/usecase/usecase.dart';
import 'package:metaltrade/features/profile/domain/repo/get_profile_repo.dart';

import '../../../../core/resource/data_state/data_state.dart';
import '../entities/profile_entity.dart';

class GetProfileUsecase extends Usecase {
  final GetProfileRepo profileRepo;
  GetProfileUsecase({required this.profileRepo});
  @override
  Future<DataState<ProfileEntity>> call(params) async {
    return await profileRepo.getProfile(params);
  }
}
