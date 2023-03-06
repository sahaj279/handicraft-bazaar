import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../common/util/snackbar.dart';
import '../../../constants/global_constants.dart';
import '../../../models/product_model.dart';
import '../../../provider/user_provider.dart';

class SearchServices{
  Future<List<Product>> getSearchedProducts({required BuildContext context,required String searchQueryStirng}) async {
    String token = Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> products = [];
    try {
      //we want a list of all products in the db a admin has added
      http.Response res = await http.get(
        Uri.parse('$domain/api/getProducts/search/$searchQueryStirng'),
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
        // Provider.of<ProductProvider>(context,listen:false).setProducts(products);
      } else {
        debugPrint(res.body);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
    return products;
  }
}