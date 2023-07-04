import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavControllerCubit extends Cubit<int> {
  BottomNavControllerCubit() : super(0);
  void changeIndex(int index) => emit(index);
}
