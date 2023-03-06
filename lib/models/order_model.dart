// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_webapp/models/product_model.dart';

class Order {
  //userid ,_id,status, totalPrice,orderedAt,address, and products which is again a list of products
  
  final String id;
  final int status;
  final double totalPrice;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final int orderedAt;

  Order({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.products,
    required this.quantity,
    required this.address,
    required this.orderedAt,
  });



  Map<String, dynamic> toMap() {//i gues we'll nevevr use this
    return <String, dynamic>{
      '_id': id,
      'status': status,
      'totalPrice': totalPrice,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'orderedAt': orderedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      status: map['status'] as int,
      totalPrice: double.parse(map['totalPrice'].toString()),
      products: List<Product>.from((map['products'])?.map((x) => Product.fromMap(x['product']),),),
      quantity: List<int>.from((map['products']?.map((x)=>x['quantity'] as int))),
      address: map['address'] as String,
      orderedAt: map['orderedAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
