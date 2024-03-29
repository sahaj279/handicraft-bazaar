import 'dart:convert';
import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/admin/model/Sale_Model.dart';
import 'package:ecommerce_webapp/models/order_model.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:ecommerce_webapp/provider/product_provider.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SuperAdminService {
  // Future<void> getAllSellers({
  //   required BuildContext context,
  //   required String name,
  //   required String desc,
  //   required double price,
  //   required int quantity,
  //   required List<Uint8List> images,
  //   required String category,
  // }) async {
  //   try {
  //     String token =
  //         Provider.of<UserProvider>(context, listen: false).user.token;

  //     Uri url = Uri.parse('$domain/admin/addProduct');
  //     http.Response res = await http.post(
  //       url,
  //       headers: {
  //         'x-auth-token': token,
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     if (res.statusCode == 200) {
  //       showSnackbar(context: context, content: 'Prodct added successfully!');
  //       Provider.of<ProductProvider>(context, listen: false).addProduct(
  //         Product.fromMap(jsonDecode(res.body)),
  //       );
  //       Navigator.pop(context);
  //     } else {
  //       showSnackbar(context: context, content: res.body);
  //     }
  //   } catch (e) {
  //     showSnackbar(context: context, content: e.toString());
  //   }
  // }

//UPDATE THE TRACKING STATUS OF ORDERS
  void updateStatus({
    required BuildContext context,
    required String order_id,
    required VoidCallback onSucess,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      Uri url = Uri.parse('$domain/admin/update-status-of-order');

      http.Response res = await http.patch(
        url,
        body: {'id': order_id},
        headers: {
          'x-auth-token': userProvider.user.token,
          // 'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        onSucess();
      } else {
        showSnackbar(context: context, content: res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  // GETTING ALL PRODUCTS OF A PARTICULAR SELLER
  Future<List<Product>> getAllSellers({required BuildContext context}) async {
    String token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> products = [];
    try {
      //we want a list of all products in the db a admin has added
      http.Response res = await http.get(
        Uri.parse('$domain/superadmin/all-products'),
        headers: {'x-auth-token': token},
      );
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          products.add(
            Product.fromMap(
              jsonDecode(res.body)[i],
            ),
          );
        }
        Provider.of<ProductProvider>(context, listen: false)
            .setProducts(products);
      } else {
        debugPrint(res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
    return products;
  }

  // GETTING ALL ORDERS OF A PARTICULAR ADMIN
  Future<List<Order>> getAllOrders({required BuildContext context}) async {
    String token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Order> orders = [];
    try {
      //we want a list of all products in the db a admin has added
      http.Response res = await http.get(
        Uri.parse('$domain/admin/all-orders'),
        headers: {'x-auth-token': token},
      );
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          orders.add(
            Order.fromMap(
              jsonDecode(res.body)[i],
            ),
          );
        }
      } else {
        debugPrint(res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
    return orders;
  }

  //DELETING A PARTICULAR PRODUCT BY ITS ID IN HEADER
  deleteAProduct(
      {required BuildContext context,
      required String productid,
      required String pname,
      required VoidCallback onSuccess}) async {
    String token = Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.delete(
        Uri.parse('$domain/admin/delete-a-product'),
        headers: {'x-auth-token': token, 'pid': productid},
      );
      if (res.statusCode == 200) {
        showSnackbar(context: context, content: '$pname removed successfully');
        onSuccess();
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  //ANALYTICS GETTING DATA
  Future<Map<String, dynamic>> getAnalyticsData(
      {required BuildContext context}) async {
    String token = Provider.of<UserProvider>(context, listen: false).user.token;

    List<Sale> sales = [];
    int totalPrice = 0;
    try {
      //we want a list of all products in the db a admin has added
      http.Response res = await http.get(
        Uri.parse('$domain/admin/analytics'),
        headers: {'x-auth-token': token},
      );
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);

        totalPrice = response['totalEarnings'] as int;
        sales = [
          Sale(label: 'Pottery', earning: response['Pottery'] as int),
          Sale(label: 'Embroidery', earning: response['Embroidery'] as int),
          Sale(label: 'Jewelry', earning: response['Jewelry'] as int),
          Sale(label: 'Paintings', earning: response['Paintings'] as int),
          Sale(label: 'Sculptures', earning: response['Sculptures'] as int),
        ];
      } else {
        debugPrint(res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
    return {'totalPrice': totalPrice, 'sales': sales};
  }
}
