part of 'add_member_cubit.dart';

@immutable
abstract class AddMemberState {}

class AddMemberInitial extends AddMemberState {}

class AddMemberSuccess extends AddMemberState {
  final bool isAdded;

  AddMemberSuccess(this.isAdded);
}

class AddMemberFailed extends AddMemberState {
  final Exception exception;

  AddMemberFailed(this.exception);
}

class GetAllEmployeeFailed extends AddMemberState {
  final Exception exception;

  GetAllEmployeeFailed(this.exception);
}

class GetAllEmployeeSuccess extends AddMemberState {
  final List<ProfileEntity> employeeList;

  GetAllEmployeeSuccess(this.employeeList);
}

class DeleteEmpSuccess extends AddMemberState {
  final String success;
  final String mobileNo;

  DeleteEmpSuccess({required this.success, required this.mobileNo});
}

class DeletingEmp extends AddMemberState {
  final String mobileNo;
  DeletingEmp(this.mobileNo);
}

class DeleteEmpFailed extends AddMemberState {
  final Exception exception;

  DeleteEmpFailed(this.exception);
}
