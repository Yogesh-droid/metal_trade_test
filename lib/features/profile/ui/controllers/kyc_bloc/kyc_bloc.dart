import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/usecases/kyc_usecase.dart';
import '../../../data/models/kyc_request_model.dart';
import '../../../domain/entities/profile_entity.dart';
part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final KycUsecase kycUsecase;
  KycBloc(this.kycUsecase) : super(KycInitial()) {
    on<KycEvent>((event, emit) async {
      if (event is DoKycEvent) {
        try {
          final DataState<ProfileEntity> dataState = await kycUsecase.call(
              RequestParams(
                  url: "${baseUrl}user",
                  apiMethods: ApiMethods.post,
                  header: header,
                  body: event.kycRequestModel.toJson()));
          if (dataState.data != null) {
            emit(KycDoneState(dataState.data!));
          } else {
            emit(KycFailedState(dataState.exception!));
          }
        } on Exception catch (e) {
          emit(KycFailedState(e));
        }
      }
    });
  }
}