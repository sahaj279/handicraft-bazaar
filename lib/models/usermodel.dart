class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final String phoneNumber;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
    required this.phoneNumber,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      phoneNumber: map['phoneNumber'] ?? '',
      id: map['_id'] ?? '',
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      address: map['address'] ?? "",
      type: map['type'] ?? "",
      token: map['token'] ?? "",
      cart: List<Map<String, dynamic>>.from(
          map['cart'].map((x) => Map<String, dynamic>.from(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
      'address': address,
      'cart': cart,
      'phoneNumber': phoneNumber,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    String? phoneNumber,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
