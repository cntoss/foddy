// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:foody/profile/profile_screen.dart';
import 'package:foody/utils/logout_helper.dart';

import '../../product/ui/home_screen.dart';
import '../cart/cart_screen.dart';
import '../cubit/bottom_nav_cubit/bottom_nav_cubit.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _home = const HomeScreen();
  final _profile = const ProfileScreen();
  final _cart = const CartScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: gettitle(state.index),
            centerTitle: true,
            actions: [
              if (state.index == 2)
                IconButton(
                  onPressed: () => LogoutHelper().logout(context),
                  icon: const Icon(
                    Icons.logout_outlined,
                  ),
                )
            ],
          ),
          body: buildPageView(state.index),
          bottomNavigationBar: _buildBtmNavBar(context, state.index),
        );
      },
    );
  }

  SnakeNavigationBar _buildBtmNavBar(BuildContext context, index) {
    return SnakeNavigationBar.color(
      backgroundColor: Colors.white,
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.indicator,
      padding: const EdgeInsets.all(0),
      snakeViewColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: index,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  Widget gettitle(int index) {
    late String title;
    switch (index) {
      case 0:
        title = 'Home';
        break;
      case 1:
        title = "Cart";
        break;
      case 2:
        title = "Profile";
        break;
      default:
        title = 'Home';
        break;
    }

    return Text(title);
  }

  /*  PageView get _buildPageView {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        BlocProvider.of<BottomNavCubit>(context).resetNavIndex(index: index);
      },
      children: [
        _cart,
        _profile,
      ],
    );
  } */

  Widget buildPageView(int index) {
    switch (index) {
      case 0:
        return _home;
      case 1:
        return _cart;
      case 2:
        return _profile;
      default:
        return _home;
    }
  }

  //
  void _onItemTapped(int index) {
    BlocProvider.of<BottomNavCubit>(context).resetNavIndex(index: index);
  }
}
