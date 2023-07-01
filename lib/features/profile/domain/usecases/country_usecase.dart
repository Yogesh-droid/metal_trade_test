import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/features/profile/domain/entities/country_entity.dart';
import 'package:metaltrade/features/profile/domain/repo/country_repo.dart';

import '../../../../core/usecase/usecase.dart';

class CountryUsecase extends Usecase {
  final CountryRepo countryRepo;

  CountryUsecase({required this.countryRepo});
  @override
  Future<DataState<List<CountryEntity>>> call(params) async {
    return await countryRepo.getCountryList(params);
  }
}
