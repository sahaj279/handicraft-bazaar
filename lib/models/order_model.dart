// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_webapp/models/product_model.dart';

class Order {
  //userid ,_id,status, totalPrice,orderedAt,address, and products which is again a list of products

  final String orderId;
  final int status;
  final double totalPrice;
  final Product product;
  final int quantity;
  final String address;
  final int orderedAt;

  Order({
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.product,
    required this.quantity,
    required this.address,
    required this.orderedAt,
  });

  Map<String, dynamic> toMap() {
    //i guess we'll never use this
    return <String, dynamic>{
      '_id': orderId,
      'status': status,
      'totalPrice': totalPrice,
      'product': product.toMap(),
      'quantity': quantity,
      'address': address,
      'orderedAt': orderedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['_id'] as String,
      status: map['status'] as int,
      totalPrice: double.parse(map['totalPrice'].toString()),
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] as int,
      address: map['address'] as String,
      orderedAt: map['orderedAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
