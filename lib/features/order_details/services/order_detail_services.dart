import 'dart:convert';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderDetailServices {
  Future<void> cancelOrder(
      BuildContext context, int status, int paymentMode, String orderId) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(
          '$domain/api/cancel-order',
        ),
        body: {
          'orderId': orderId,
          'paymentMode': paymentMode,
          'status': status,
        },
        headers: {'x-auth-token': userProvider.user.token},
      );
      if (res.statusCode == 200) {
        print('#4');
        print(jsonDecode(res.body));
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
