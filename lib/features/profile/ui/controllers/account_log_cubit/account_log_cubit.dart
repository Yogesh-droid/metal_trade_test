import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_log_state.dart';

class AccountLogCubitCubit extends Cubit<AccountLogCubitState> {
  AccountLogCubitCubit() : super(AccountLogCubitInitial());
}
