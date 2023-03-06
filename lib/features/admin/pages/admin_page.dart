import 'package:ecommerce_webapp/features/admin/pages/all_products.dart';
import 'package:ecommerce_webapp/features/admin/pages/analytics_page.dart';
import 'package:ecommerce_webapp/features/admin/pages/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_constants.dart';
import '../../authentication/auth_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _page = 0;
  final double _bottomBarIconWidth = 5;
  final double _bottomBarWidth = 40;

  List<Widget> screens = const [
    AllProducts(),
    AnalyticsPage(),
    OrdersPageAdmin(),
  ];

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: ()async {
                 SharedPreferences preferences = await SharedPreferences.getInstance();
                 await preferences.setString('x-auth-token', '');
                 Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                                builder: (context) => const AuthPage(),
                              ),
                              (route) => false);
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          actions: [
            InkWell(
              onTap: () => _dialogBuilder(context),
             
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.more_vert_sharp,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.orange,
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Handicraft Bazaar',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text('Admin',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600))),
            ],
          ),
        ),
      ),
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
          //POSTS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: _bottomBarIconWidth,
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor),
                  ),
                ),
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: _bottomBarIconWidth,
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor),
                  ),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                ),
              ),
              label: ''),

          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: _bottomBarIconWidth,
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor),
                  ),
                ),
                child: const Icon(
                  Icons.all_inbox_outlined,
                ),
              ),
              label: ''),
        ],
      ),
    );
  }
}
