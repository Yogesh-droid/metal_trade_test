import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/usecases/get_profile_usecase.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../domain/usecases/delete_acc_usecase.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;
  ProfileEntity? profileEntity;
  ProfileBloc(
      {required this.getProfileUsecase, required this.deleteAccountUsecase})
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetUserProfileEvent) {
        try {
          final String token = await LocalStorage.instance.getToken();
          final DataState<ProfileEntity> dataState =
              await getProfileUsecase.call(RequestParams(
                  url: "${baseUrl}user",
                  apiMethods: ApiMethods.get,
                  header: {
                "Authorization": "Bearer $token",
                "Content-Type": "application/json"
              }));
          if (dataState.data != null) {
            if (dataState.data!.company != null) {
              LocalStorage.instance
                  .saveUserCompanyId(dataState.data!.company!.id!);
            }
            profileEntity = dataState.data!;
            emit(ProfileSuccessState(profileEntity: dataState.data!));
          } else {
            emit(ProfileFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(ProfileFailed(e));
        }
      }
      if (event is LogoutUserProfileEvent) {
        LocalStorage.instance.deleteToken();
        emit(ProfileLoggedOut());
      }
      if (event is DeleteAccount) {
        deleteAccountUsecase.call(RequestParams(
            url: '${baseUrl}user/account',
            apiMethods: ApiMethods.delete,
            body: {"mobileNumber": event.phoneNo},
            header: header));
        LocalStorage.instance.deleteToken();
        emit(ProfileLoggedOut());
      }
      if (event is EmitKycDoneEvent) {
        emit(KycCompletedState());
      }
    });
  }
}
