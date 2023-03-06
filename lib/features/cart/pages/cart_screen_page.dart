import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/common/widgets/common_button.dart';
import 'package:ecommerce_webapp/features/cart/widgets/cart_product.dart';
import 'package:ecommerce_webapp/features/cart/widgets/cart_subtotal.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/widgets/address_box.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../address/screens/address_screen.dart';
import '../../search/screens/search_screen.dart';

class CartScreenPage extends StatefulWidget {
  const CartScreenPage({super.key});

  @override
  State<CartScreenPage> createState() => _CartScreenPageState();
}

class _CartScreenPageState extends State<CartScreenPage> {
  onSearchTapped(String query) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SearchScreenHomePage(searchQuery: query);
      },
    ));
  }

  navigateToAddressScreen(double totalAmount) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => AddressScreen(
                  totalAmount: totalAmount,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    double totalPrice = 0;
    //both are same
    user.cart.map((e) {
      totalPrice += e['quantity'] * e['product']['price'] ;/// as int was written here first
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: onSearchTapped,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                color: Colors.black38, width: 1),
                          ),
                          hintText: 'Search the bazaar',
                          hintStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              ),
              Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AddressBox(),
          user.cart.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Your cart is empty :(\nAdd some products to cart first!',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CartSubtotal(),
                        const SizedBox(
                          height: 15,
                        ),
                        CommonButton(
                          onTap: () {
                            if (user.cart.isEmpty) {
                              showSnackbar(
                                  context: context,
                                  content: 'Add some products to cart first!');
                            } else {
                              navigateToAddressScreen(totalPrice);
                            }
                          },
                          buttonText:
                              'Proceed to buy (${user.cart.length} items)',
                          color: Colors.yellow.shade600,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.black12.withOpacity(0.08),
                          height: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: user.cart.length,
                            itemBuilder: ((context, index) {
                              return CartProduct(
                                index: index,
                              );
                            })),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
