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
