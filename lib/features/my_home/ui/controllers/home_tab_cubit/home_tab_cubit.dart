import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(HomeTabStateInitial());
  void changeTab(int index) {
    emit(HomeTabStateUpdate(index: index));
  }
}
