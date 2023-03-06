import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
        decoration:
            const BoxDecoration(gradient: GlobalVariables.appBarGradientVertical),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Hello, ',
                      style:const TextStyle(fontSize: 22, color: Colors.black,fontFamily: "Oswald"),
                      children: [
                        TextSpan(
                            text: Provider.of<UserProvider>(context).user.name,
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600))
                      ]),
                ),
              ],
            ),
            const SizedBox(height: 10,)
          ],
        ));
  }
}
