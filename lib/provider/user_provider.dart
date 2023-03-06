import 'package:ecommerce_webapp/models/usermodel.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier{
  User _user=User(id: '', name: '', email: '', password: '', address: '', type: '', token: '',cart: []);

  User get user =>_user;

  void setUser(User user){
    _user=user;
    notifyListeners();
  }
}