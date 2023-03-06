import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/profile/widgets/below_app_bar.dart';
import 'package:ecommerce_webapp/features/profile/widgets/column_row.dart';
import 'package:ecommerce_webapp/features/profile/widgets/orders.dart';
import 'package:flutter/material.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({super.key});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
                child:const Text('Handicraft Bazaar'),
              ),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children:const [
                    Padding(
                      padding: EdgeInsets.only(right:15.0),
                      child: Icon(Icons.notifications_outlined,color: Colors.black,),
                    ), 
                    Icon(Icons.search,color: Colors.black,)
                  ],
                )

              ),
            ],
          ),
        ),
      ),
      body: Column(children:const [
        BelowAppBar(),
        ColumnRowWithChips(),
        SizedBox(height: 20,),
        OrdersView(),

      ]),
    );
  }
}
