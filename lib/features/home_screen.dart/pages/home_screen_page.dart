import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/widgets/address_box.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/widgets/carousels.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/widgets/deal_of_the_day.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/widgets/top_categories.dart';
import 'package:ecommerce_webapp/features/search/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  onSearchEntered(String query) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SearchScreenHomePage(
          searchQuery: query,
          emptySearchQuery: query.trim() == '',
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    print('#### ${Provider.of<UserProvider>(context).user.email}');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBar(
          toolbarHeight: 72,
          titleSpacing: 0,
          backgroundColor: Colors.orange,
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Container(
            margin: const EdgeInsets.all(15),
            height: 42,
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 1,
              child: TextFormField(
                onFieldSubmitted: onSearchEntered,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                  hintText: 'Search the bazaar',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          // actions: [
          //   Container(
          //     height: 42,
          //     padding: const EdgeInsets.symmetric(horizontal: 15),
          //     child: const Icon(
          //       Icons.mic,
          //       color: Colors.black,
          //     ),
          //   ),
          // ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(height: 10),
            CarouselsView(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            DealOfTheDay(),
            SizedBox(height: 10),
            //TODO: Deal of the day
          ],
        ),
      ),
    );
  }
}
