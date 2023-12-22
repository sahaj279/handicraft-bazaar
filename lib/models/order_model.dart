// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_webapp/models/product_model.dart';

class Order {
  final String orderId;
  final String sellerId;
  final int status;
  final double totalPrice;
  final Product product;
  final int quantity;
  final String address;
  final int orderedAt;
  final String phoneNumber;
  final int paymentMode;
  final String stripePaymentId;

  Order({
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.product,
    required this.quantity,
    required this.address,
    required this.orderedAt,
    required this.phoneNumber,
    required this.stripePaymentId,
    required this.paymentMode,
    required this.sellerId,
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
      'paymentMode': paymentMode,
      'stripePaymentId': stripePaymentId,
      'phoneNumber': phoneNumber,
      'sellerId': sellerId,
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
      paymentMode: map['paymentMode'] as int,
      phoneNumber: map['phoneNumber'] as String,
      stripePaymentId: map['stripePaymentId'] as String,
      sellerId: map['sellerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
