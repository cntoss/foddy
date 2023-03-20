import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:foody/auth/auth_gate.dart';
import 'package:foody/presentation/cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:foody/presentation/home/main_screen.dart';
import 'package:foody/presentation/product/ui/add_product.dart';

import 'core/locator.dart';
import 'core/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const providerConfigs = [EmailProviderConfiguration()];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<BottomNavCubit>()),
      ],
      child: MaterialApp(
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? '/sign-in'
            : '/main-screen',
        routes: {
          '/sign-in': (context) => const AuthGate(),
          '/profile': (context) =>
              const ProfileScreen(providerConfigs: providerConfigs),
          '/main-screen': (context) => const MainScreen(),
          '/add-product': (context) => const AddProduct()
        },
        theme: LightTheme.data,
      ),
    );
  }
}
