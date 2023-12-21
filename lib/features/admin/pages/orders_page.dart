import 'package:flutter/material.dart';

import 'package:ecommerce_webapp/common/widgets/circular_loader.dart';
import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
import 'package:ecommerce_webapp/features/order_details/screens/order_detail_screen.dart';
import 'package:ecommerce_webapp/features/profile/widgets/single_product.dart';
import 'package:ecommerce_webapp/models/order_model.dart';

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
        ? const CircularLoader()
        : orders!.isEmpty
            ? const Center(
                child: Text(
                  'No orders yet, add more products which users might buy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'All Orders',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: orders!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          //TODO: Show more details of order like date placed, order status here on grid view
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                  order: orders![index],
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 120,
                            child: SingleProduct(
                              image: orders![index].product.images[0],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
  }
}
