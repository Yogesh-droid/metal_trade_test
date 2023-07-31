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
