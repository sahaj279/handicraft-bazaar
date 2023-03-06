import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/order_details/screens/order_detail_screen.dart';
import 'package:ecommerce_webapp/features/profile/services/profile_services.dart';
import 'package:ecommerce_webapp/features/profile/widgets/single_product.dart';
import 'package:ecommerce_webapp/models/order_model.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  List<Order>? orders;
  // List list = [
  //   'https://images-eu.ssl-images-amazon.com/images/W/WEBP_402378-T1/images/G/31/img21/PC/Computers/Revamp/xcm_banners_01_tiles_v1_440x460_in-en.jpg',
  //   'https://images-eu.ssl-images-amazon.com/images/W/WEBP_402378-T1/images/G/31/img21/PC/Computers/Revamp/xcm_banners_01_tiles_v1_440x460_in-en.jpg',
  //   'https://images-eu.ssl-images-amazon.com/images/W/WEBP_402378-T1/images/G/31/img21/PC/Computers/Revamp/xcm_banners_01_tiles_v1_440x460_in-en.jpg',
  //   'https://images-eu.ssl-images-amazon.com/images/W/WEBP_402378-T1/images/G/31/img21/PC/Computers/Revamp/xcm_banners_01_tiles_v1_440x460_in-en.jpg',
  // ];

  @override
  void initState() {
    fetchOrders();

    super.initState();
  }

  fetchOrders() async {
    orders = await ProfileServices().fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Your Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text(
              'See all',
              style: TextStyle(color: GlobalVariables.selectedNavBarColor),
            ),
          )
        ]),
        //display orders
        orders == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : orders!.isEmpty
                ? const Center(
                    child: Text('No orders, Place an order'),
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailsScreen(order: orders![index]),
                                ),
                              );
                            },
                            child: SingleProduct(
                                image: orders![index].products[0].images[0]),
                          ),
                        );
                      },
                    ),
                  ),
      ],
    );
  }
}
