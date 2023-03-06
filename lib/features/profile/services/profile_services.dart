import 'dart:convert';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/models/order_model.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';

class ProfileServices {
  Future<List<Order>> fetchAllOrders({
    required BuildContext context,
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orders=[];
    try {
      http.Response res =
          await http.get(Uri.parse('$domain/api/get-all-orders'), headers: {
        'x-auth-token': userProvider.user.token,
      });
      //we get a list of orders where each order has 
      //userid ,_id,status, totalPrice,orderedAt,address, and products which is again a list of products
      if(res.statusCode==200){
        for(int i=0;i<jsonDecode(res.body).length;i++){
          orders.add(Order.fromMap(jsonDecode(res.body)[i]));
        }
        print(jsonDecode(res.body));
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
    return orders;
  }
}
