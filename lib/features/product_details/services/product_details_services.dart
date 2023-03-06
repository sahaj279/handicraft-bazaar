import 'dart:convert';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/models/usermodel.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/product_model.dart';

class ProductDetailsServices {
  Future<void> addToCart(
      {required BuildContext context, required Product product}) async {
    try {
      var userProvider=Provider.of<UserProvider>(context,listen: false);
      String token =userProvider.user.token;
      http.Response res = await http.post(
        Uri.parse('$domain/api/add-to-cart'),
        headers: {'x-auth-token': token},
        body: {'id': product.id!},
      );
      debugPrint(res.body);

      if (res.statusCode == 200) {
        User u=userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
        userProvider.setUser(u);

        // debugPrint(res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  Future<void> rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    try {
      // debugPrint('Method Called');
      String token =
          Provider.of<UserProvider>(context, listen: false).user.token;
      http.Response res = await http.post(
        Uri.parse('$domain/api/rate-product'),
        headers: {'x-auth-token': token},
        body: {'id': product.id!, 'rating': rating.toString()},
      );
      // debugPrint(res.body);

      if (res.statusCode == 200) {
        debugPrint(res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
