import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(index: 0));

  void resetNavIndex({int? index}) {
    emit(state.copyWith(index: index ?? 0));
  }
}
