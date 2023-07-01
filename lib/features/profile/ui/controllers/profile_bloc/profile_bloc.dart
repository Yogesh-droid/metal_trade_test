import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/usecases/get_profile_usecase.dart';
import '../../../domain/entities/profile_entity.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  ProfileEntity? profileEntity;
  ProfileBloc(this.getProfileUsecase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetUserProfileEvent) {
        try {
          final DataState<ProfileEntity> dataState =
              await getProfileUsecase.call(RequestParams(
                  url: "${baseUrl}user",
                  apiMethods: ApiMethods.get,
                  header: header));
          if (dataState.data != null) {
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
    });
  }
}
