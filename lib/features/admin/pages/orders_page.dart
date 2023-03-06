import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
import 'package:ecommerce_webapp/features/profile/widgets/single_product.dart';
import 'package:ecommerce_webapp/models/order_model.dart';
import 'package:flutter/material.dart';

import '../../order_details/screens/order_detail_screen.dart';

class OrdersPageAdmin extends StatefulWidget {
  const OrdersPageAdmin({super.key});

  @override
  State<OrdersPageAdmin> createState() => _OrdersPageAdminState();
}

class _OrdersPageAdminState extends State<OrdersPageAdmin> {
  List<Order>? orders;

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  getOrders() async {
    orders = await AdminServices().getAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : orders!.isEmpty
            ? const Center(
                child: Text('No Orders yet'),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    itemCount: orders!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                  order: orders![index],
                                ),
                              ));
                        },
                        child: SizedBox(
                          height: 120,
                          child: SingleProduct(
                              image: orders![index].products[0].images[0]),
                        ),
                      );
                    }),
              );
  }
}
