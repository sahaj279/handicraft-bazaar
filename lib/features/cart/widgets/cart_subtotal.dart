import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    final user = Provider.of<UserProvider>(context).user;
    //both are same
    user.cart.map((e) {
      totalPrice += e['quantity'] * e['product']['price'] as int;
    }).toList();
    // for(int i=0;i<user.cart.length;i++){
    //    totalPrice += user.cart[i]['quantity'] * user.cart[i]['product']['price'];

    // }

    return RichText(
      text: TextSpan(
        text: 'Subtotal ',
        style: const TextStyle(fontSize: 20,color: Colors.black),
        children: [
          TextSpan(
            text: '\$$totalPrice',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
