import 'package:ecommerce_webapp/models/ratings_model.dart';

class Product {
  final String name;
  final String desc;
  final String category;
  final double price;
  final int quantity;
  final List<String> images;
  final String? id;
  final String? userid;
  final List<Rating>? ratings;
  //rating

  Product(
      {required this.name,
      required this.desc,
      required this.category,
      required this.price,
      required this.quantity,
      required this.images,
      this.id,
      this.userid,
      this.ratings});

  Map<String, dynamic> toMap() {
    return {
      '_id': id ?? "",
      'name': name,
      'desc': desc,
      'category': category,
      'price': price,
      'quantity': quantity,
      'images': images,
      'userid': userid ?? "",
      'ratings': ratings
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    // print(map.toString());
    // print('error yaha h from map me');
    return Product(
      name: map['name'] ?? '',
      desc: map['desc'] ?? '',
      category: map['category'] ?? '',
      price: double.parse( map['price'].toString()),
      quantity: map['quantity'] ?? 0,
      images: List<String>.from(map['images']),
      id: map['_id'],
      userid: map['userid'],
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) {
                  return Rating.fromMap(x);
                },
              ),
            )
          : null,
    );
  }
}
