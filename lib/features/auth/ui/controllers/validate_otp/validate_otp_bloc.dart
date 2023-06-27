import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../domain/usecases/validate_otp_usecase.dart';

part 'validate_otp_event.dart';
part 'validate_otp_state.dart';

class ValidateOtpBloc extends Bloc<ValidateOtpEvent, ValidateOtpState> {
  final ValidateOtpUsecase validateOtpUsecase;
  ValidateOtpBloc({required this.validateOtpUsecase})
      : super(ValidateOtpInitial()) {
    on<ValidateOtpEvent>((event, emit) async {
      if (event is GetValidateOtpEvent) {
        try {
          DataState<String> dataState = await validateOtpUsecase.call(
              RequestParams(
                  url: "${baseUrl}auth/validate",
                  apiMethods: ApiMethods.post,
                  body: {"mobileNumber": event.phoneNo, "otp": event.otp}));
          if (dataState.data != null) {
            emit(ValidateOtpSuccess(token: dataState.data!));
          } else {
            emit(ValidateOtpFailed(exception: dataState.exception!));
          }
        } on Exception catch (e) {
          emit(ValidateOtpFailed(exception: e));
        }
      }
    });
  }
}
