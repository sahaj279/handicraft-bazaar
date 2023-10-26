import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/admin/pages/admin_page.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileService {
  Future<void> turnSeller(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$domain/api/turn-seller'), headers: {
        "Content-Type": "application/json",
        'x-auth-token': userProvider.user.token,
      });
      if (res.statusCode == 200) {
        showSnackbar(context: context, content: 'Seller dashboard unlocked.');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => const AdminPage())),
            (route) => false);
      } else {
        showSnackbar(context: context, content: 'Some error occured.');
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
