import 'dart:convert';
import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/admin/pages/admin_page.dart';
import 'package:ecommerce_webapp/features/authentication/auth_page.dart';
import 'package:ecommerce_webapp/models/usermodel.dart';
import 'package:ecommerce_webapp/pages/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/user_provider.dart';

class AuthServices {

  //Signing up
  Future<String> signup(String name, String password, String email) async {
    String s = "Error";
    try {
      // print('signup api');
      
      Uri url = Uri.parse("$domain/api/signup");
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart:[]);
          // print(user.toString());
          print(user.toMap().toString());

      http.Response res = await http.post(url, body: jsonEncode(user.toMap()),headers: {'Content-Type': 'application/json'});
      //TODO response status error handling in snackbar 
      //using json decode

      s =  res.body.toString();
      print(s);
    } catch (e) {
      s = e.toString();
    }
    return s;
  }

  //logging in
  Future<String> login(String password, String email,BuildContext context) async {
    String s = "Error";
    try {
      Uri url = Uri.parse("$domain/api/login");
      http.Response res = await http.post(url, body:jsonEncode({'email':email,'password':password}),headers: {'Content-Type': 'application/json'});
      //TODO response status error handling in snackbar 
      //using json decode
      s =  res.body.toString();
      //now the token that has been received, we'll store it in shared_preferences and save whole data in userprovider
      if(res.statusCode==200){
        print('logged in');
        s=jsonDecode(res.body)['type']=="admin"?"1":"2";
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context,listen: false).setUser(User.fromMap(jsonDecode(res.body))) ;
        SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setString('x-auth-token', jsonDecode(res.body)['token'] );
      }
    } catch (e) {
      s = e.toString();
    }
    return s;
  }

  Future<void> getUserData(BuildContext context)async{
    try {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      String? token=prefs.getString('x-auth-token');
      if(token==null){
        prefs.setString('x-auth-token', '');
        //Go to auth screen as no token 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AuthPage()));
        return ;
      }
      //now we have to validate this token 
      http.Response tokenRes=await http.post(Uri.parse('$domain/isTokenValid'),headers: <String,String>{'x-auth-token':token} );
      var res=jsonDecode(tokenRes.body);
      if(res==true){
        //now getting the user data
       http.Response userDataRes=await  http.get(Uri.parse('$domain/getUserData'),headers: <String,String>{'x-auth-token':token} );
       var userData=jsonDecode(userDataRes.body);
       Provider.of<UserProvider>(context,listen: false).setUser(User.fromMap(userData));
       if(userData['type']=='admin'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AdminPage()));
       }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottombarPage()));
       }
      }
    } catch (e) {
      showSnackbar(context: context, content: e.toString());
    }
  }
}
