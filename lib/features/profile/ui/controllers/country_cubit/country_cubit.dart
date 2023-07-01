import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/usecases/country_usecase.dart';
import '../../../domain/entities/country_entity.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryUsecase countryUsecase;
  CountryCubit(this.countryUsecase) : super(CountryInitial());

  Future<void> getCountries() async {
    try {
      final DataState<List<CountryEntity>> dataState =
          await countryUsecase.call(RequestParams(
              url: "${baseUrl}country", apiMethods: ApiMethods.get));
      if (dataState.data != null) {
        emit(CountrySuccess(dataState.data!));
      } else {
        emit(CountryFailedState(Exception(dataState.exception)));
      }
    } on Exception catch (e) {
      emit(CountryFailedState(e));
    }
  }
}
