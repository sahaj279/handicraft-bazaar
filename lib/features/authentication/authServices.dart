import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/admin/pages/admin_page.dart';
import 'package:ecommerce_webapp/features/authentication/auth_page.dart';
import 'package:ecommerce_webapp/features/landing_page/landing_page.dart';
import 'package:ecommerce_webapp/features/super_admin/views/super_admin_landing_page.dart';
import 'package:ecommerce_webapp/models/usermodel.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';

class AuthServices {
  //Signing up
  Future<void> signup(
    String name,
    String password,
    String email,
    BuildContext context,
  ) async {
    try {
      Uri url = Uri.parse("$domain/api/signup");
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
        phoneNumber: '',
      );

      http.Response res = await http.post(
        url,
        body: jsonEncode(user.toMap()),
        headers: {'Content-Type': 'application/json'},
      );
      String message = "SignUp successfully, login with same credentials.";
      switch (res.statusCode) {
        case 400:
          message = jsonDecode(res.body)['message'];
          break;
        case 500:
          message =
              'Invalid email or password, password must have atleast 8 characters.';
          break;
      }
      showSnackbar(context: context, content: message);
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  //logging in
  Future<void> login(
    String password,
    String email,
    BuildContext context,
  ) async {
    try {
      Uri url = Uri.parse("$domain/api/login");
      http.Response res = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      //now the token that has been received, we'll store it in shared_preferences and save whole data in userprovider
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setUser(User.fromMap(jsonDecode(res.body)));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        showSnackbar(
            context: context,
            content: 'Logged in as ${jsonDecode(res.body)['name']}');

        if (Provider.of<UserProvider>(context, listen: false).user.type ==
            "user") {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const LandingPage();
            },
          ));
        } else if (Provider.of<UserProvider>(context, listen: false)
                .user
                .type ==
            "super admin") {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const SuperAdminLandingPage();
            },
          ));
        } else if (Provider.of<UserProvider>(context, listen: false)
                .user
                .type ==
            "admin") {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const AdminPage();
            },
          ));
        } else {
          showSnackbar(context: context, content: 'Some error occurred.');
        }
      } else if (res.statusCode == 500) {
        showSnackbar(context: context, content: jsonDecode(res.body)['error']);
      } else if (res.statusCode == 400 || res.statusCode == 401) {
        showSnackbar(
            context: context, content: jsonDecode(res.body)['message']);
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
        //Go to auth screen as no token
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AuthPage()));
        return;
      }
      //now we have to validate this token
      http.Response tokenRes = await http.post(
        Uri.parse('$domain/isTokenValid'),
        headers: <String, String>{'x-auth-token': token},
      );
      var res = jsonDecode(tokenRes.body);
      if (res == true) {
        //now getting the user data
        http.Response userDataRes = await http.get(
            Uri.parse('$domain/getUserData'),
            headers: <String, String>{'x-auth-token': token});
        var userData = jsonDecode(userDataRes.body);
        Provider.of<UserProvider>(context, listen: false)
            .setUser(User.fromMap(userData));
        if (userData['type'] == 'admin') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AdminPage()));
        } else if (userData['type'] == 'super admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SuperAdminLandingPage()),
          );
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LandingPage()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AuthPage()));
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthPage()));
    }
  }
}
