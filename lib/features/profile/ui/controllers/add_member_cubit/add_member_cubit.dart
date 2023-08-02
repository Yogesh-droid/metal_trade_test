import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/domain/usecases/add_member_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/delete_emp_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/get_all_employee_usecase.dart';
part 'add_member_state.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  final AddMemberUsecase addMemberUsecase;
  final GetAllEmployeeUsecase getAllEmployeeUsecase;
  final DeleteEmpUsecase deleteEmpUsecase;
  AddMemberCubit(
      this.addMemberUsecase, this.getAllEmployeeUsecase, this.deleteEmpUsecase)
      : super(AddMemberInitial());
  List<ProfileEntity> allEmployeeList = [];

  Future<void> getAllEmployees() async {
    try {
      DataState<List<ProfileEntity>> dataState =
          await getAllEmployeeUsecase.call(RequestParams(
              url: "${baseUrl}user/employee",
              apiMethods: ApiMethods.get,
              header: header));
      if (dataState.data != null) {
        allEmployeeList.clear();
        allEmployeeList.addAll(dataState.data!);
        emit(GetAllEmployeeSuccess(allEmployeeList));
      } else {
        emit(GetAllEmployeeFailed(dataState.exception!));
      }
    } on Exception catch (e) {
      emit(GetAllEmployeeFailed(e));
    }
  }

  Future<void> addMember(String phoneNo) async {
    try {
      DataState<ProfileEntity> dataState = await addMemberUsecase.call(
          RequestParams(
              url: "${baseUrl}user/employee",
              apiMethods: ApiMethods.post,
              header: header,
              body: {"mobileNumber": phoneNo}));

      if (dataState.data != null) {
        allEmployeeList.add(dataState.data!);
        emit(AddMemberSuccess(true));
      } else {
        emit(AddMemberFailed(Exception("Failed to add member")));
      }
    } on Exception catch (e) {
      emit(AddMemberFailed(e));
    }
  }

  Future<void> deleteEmp(String mobileNo) async {
    try {
      DataState<String> dataState = await deleteEmpUsecase.call(RequestParams(
          url: "${baseUrl}user/employee",
          apiMethods: ApiMethods.delete,
          body: {"mobileNumber": mobileNo},
          header: header));
      if (dataState.data != null) {
        allEmployeeList
            .removeWhere((element) => element.mobileNumber == mobileNo);
        emit(DeleteEmpSuccess(success: dataState.data!, mobileNo: mobileNo));
      } else {
        emit(DeleteEmpFailed(Exception(dataState.exception)));
      }
    } on Exception catch (e) {
      emit(DeleteEmpFailed(e));
    }
  }
}
