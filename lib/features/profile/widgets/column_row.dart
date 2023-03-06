
import 'package:ecommerce_webapp/features/authentication/auth_page.dart';
import 'package:ecommerce_webapp/features/profile/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColumnRowWithChips extends StatelessWidget {
  const ColumnRowWithChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          CustomChip(text: 'Your Orders',onTap: (){},),
          CustomChip(text: 'Turn Seller',onTap: (){},),
        ],),
        const SizedBox(height: 10,),
        Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          CustomChip(text: 'Log Out',onTap:()async {
            SharedPreferences preferences=await SharedPreferences.getInstance();
            await preferences.setString('x-auth-token', '');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthPage(),), (route) => false);
          
          },),
          CustomChip(text: 'Your Wish List',onTap: (){},),
        ],),
    ],);
  }
}