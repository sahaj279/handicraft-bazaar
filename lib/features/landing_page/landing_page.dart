import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/cart/pages/cart_screen_page.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/pages/home_screen_page.dart';
import 'package:ecommerce_webapp/features/profile/screens/profile_screen_page.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _page = 0;
  final double _bottomBarIconWidth = 5;
  final double _bottomBarWidth = 40;

  List<Widget> screens = [
    const HomeScreenPage(),
    const ProfileScreenPage(),
    const CartScreenPage(),
  ];
  @override
  Widget build(BuildContext context) {
    var cartLen = Provider.of<UserProvider>(context).user.cart.length;
    return Scaffold(
      body: screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        currentIndex: _page,
        iconSize: 28,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: _bottomBarIconWidth,
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: _bottomBarIconWidth,
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outlined,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: _bottomBarIconWidth,
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.blue,
                ),
                badgeContent: Text(
                  cartLen.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
