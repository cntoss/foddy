// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_nav_cubit.dart';

class BottomNavState {
  final int index;

  const BottomNavState({
    required this.index,
  });

  BottomNavState copyWith({
    int? index,
  }) {
    return BottomNavState(
      index: index ?? this.index,
    );
  }
}
