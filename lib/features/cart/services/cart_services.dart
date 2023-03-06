import 'dart:convert';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/models/usermodel.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  decrementQuantity(
      {required BuildContext context, required String productid}) async {
        final userProvider=Provider.of<UserProvider>(context,listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse('$domain/api/remove-from-cart'),
          body: {'id': productid},  
          headers: {'x-auth-token':userProvider.user.token}
          );
        if(res.statusCode==200){
          User u=userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUser(u);
        }  


    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
