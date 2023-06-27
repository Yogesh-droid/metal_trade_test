import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';

import '../../../domain/usecases/login_usecase.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is GetOtpEvent) {
        try {
          DataState<String> dataState = await loginUsecase.call(RequestParams(
              url: "${baseUrl}auth/generate",
              apiMethods: ApiMethods.post,
              body: {"mobileNumber": event.mobNo}));

          if (dataState.data != null) {
            emit(
                LoginSuccessfulState(otp: dataState.data!, mobNo: event.mobNo));
          } else {
            emit(LoginFailedState(Exception("No Data Found")));
          }
        } on Exception catch (e) {
          emit(LoginFailedState(e));
        }
      }
    });
  }
}
