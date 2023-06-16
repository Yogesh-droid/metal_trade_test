import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/country_code_model.dart';

class CountryCodeController extends Cubit<CountryCodeModel> {
  CountryCodeController(super.initialState);

  void changeCountryCode(CountryCodeModel countryCodeModel) {
    emit(countryCodeModel);
  }
}
