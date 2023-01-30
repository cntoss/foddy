// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:foody/profile/profile_screen.dart';
import 'package:foody/utils/logout_helper.dart';

import '../../product/ui/home_screen.dart';
import '../cart/cart_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  final _home = const HomeScreen();
  final _profile = const ProfileScreen();
  final _cart = const CartScreen();
  int _screen = 0;

  @override
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _screen);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: gettitle(),
        centerTitle: true,
        actions: [
          if (_screen == 2)
            IconButton(
              onPressed: () => LogoutHelper().logout(context),
              icon: const Icon(
                Icons.logout_outlined,
              ),
            )
        ],
      ),
      body: _buildPageView,
      bottomNavigationBar: _buildBtmNavBar(context),
    );
  }

  SnakeNavigationBar _buildBtmNavBar(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.indicator,
      padding: const EdgeInsets.all(0),
      snakeViewColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: _screen,
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

  Widget gettitle() {
    late String title;
    switch (_screen) {
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

  PageView get _buildPageView {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        setState(
          () => _screen = index,
        );
      },
      children: [
        _home,
        _cart,
        _profile,
      ],
    );
  }

  //
  void _onItemTapped(int index) {
    setState(() {
      _screen = index;

      _pageController.jumpToPage(
        index,
      );
    });
  }
}
