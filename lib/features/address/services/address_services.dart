import 'dart:convert';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/usermodel.dart';

class AddressServices {
  Future<void> saveUserAddress(BuildContext context, String address) async {
    print('#3');
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$domain/api/save-address',
        ),
        body: {
          'address': address,
        },
        headers: {'x-auth-token': userProvider.user.token},
      );
      if (res.statusCode == 200) {
        print('#4');
        // print( jsonDecode(res.body));

        User u = userProvider.user.copyWith(address: jsonDecode(res.body)['address']);
        userProvider.setUser(u);
        print('#5');
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  //Placing an order
  Future<void> placeOrder(
      {required BuildContext context,
      required String address,
      required double totalPrice}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    print('#7');
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$domain/api/order',
        ),
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'totalPrice': totalPrice,
          'address': address,
        }),
        headers: {
          "Content-Type": "application/json",
          'x-auth-token': userProvider.user.token},
      );
      print('#8');
      print(res.body);
      if(res.statusCode==400){
        showSnackbar(context: context, content: jsonDecode(res.body)['message']);

      }
      if (res.statusCode == 200) {
        print('#9');
        Navigator.of(context).pop();
        showSnackbar(context: context, content: 'Your Order has been placed successfully!');
        User u = userProvider.user.copyWith(cart: []);
        userProvider.setUser(u);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
