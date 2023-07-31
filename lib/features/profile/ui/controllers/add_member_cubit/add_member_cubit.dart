import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/usecases/add_member_usecase.dart';
part 'add_member_state.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  final AddMemberUsecase addMemberUsecase;
  AddMemberCubit(this.addMemberUsecase) : super(AddMemberInitial());

  Future<void> addMember(String phoneNo) async {
    try {
      DataState<bool> dataState = await addMemberUsecase.call(RequestParams(
          url: "${baseUrl}user/employee",
          apiMethods: ApiMethods.post,
          body: {"mobileNumber": phoneNo}));

      if (dataState.data != null) {
        emit(AddMemberSuccess(true));
      } else {
        emit(AddMemberFailed(Exception("Failed to add member")));
      }
    } on Exception catch (e) {
      emit(AddMemberFailed(e));
    }
  }
}
