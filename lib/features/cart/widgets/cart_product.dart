import 'package:ecommerce_webapp/features/cart/services/cart_services.dart';
import 'package:ecommerce_webapp/features/product_details/services/product_details_services.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  incrementQuantity() {}

  @override
  Widget build(BuildContext context) {
    final productMap = Provider.of<UserProvider>(context).user.cart[index];
    final product = Product.fromMap(productMap['product']);
    final quantity = productMap['quantity'];
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      '\$${product.price.toString()}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text('Eligible for FREE Shipping'),
                    const Text(
                      'in Stock',
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ],
                ),
              ))
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 32,
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(color: Colors.black12, width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()async{
                   await CartServices().decrementQuantity(context: context, productid: product.id!);
                  },
                  child: Container(
                    width: 35,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      size: 16,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 35,
                  alignment: Alignment.center,
                  child: Text(quantity.toString()),
                ),
                Container(
                  width: 35,
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: () async {
                        await ProductDetailsServices()
                            .addToCart(context: context, product: product);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 16,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
