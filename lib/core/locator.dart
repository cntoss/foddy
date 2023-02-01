import 'package:get_it/get_it.dart';

import '../presentation/cubit/bottom_nav_cubit/bottom_nav_cubit.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton<BottomNavCubit>(BottomNavCubit());
}
