import 'package:flutter/widgets.dart';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  void setProducts(List<Product> products) {
    this.products = products;
    notifyListeners();
  }
}
