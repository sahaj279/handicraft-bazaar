import 'package:ecommerce_webapp/common/widgets/common_button.dart';
import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
import 'package:ecommerce_webapp/features/order_details/services/order_detail_services.dart';
import 'package:ecommerce_webapp/models/order_model.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../search/screens/search_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  onSearchEntered(String query) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SearchScreenHomePage(
          searchQuery: query,
          emptySearchQuery: query.trim() == '',
        );
      },
    ));
  }

  cancelOrder(int status, int paymentMode, orderId) async {
    await OrderDetailServices()
        .cancelOrder(context, status, paymentMode, orderId);
  }

  @override
  void initState() {
    currentStep = widget.order.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
                      onFieldSubmitted: onSearchEntered,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
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
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search the bazaar',
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 42,
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: const Icon(
              //     Icons.mic,
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                // width: 300,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Order Date:'),
                      Text('Order ID:'),
                      Text('Order Total:'),
                      Text('Address:'),
                      Text('Phone Number:'),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat().format(
                          DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderedAt,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(widget.order.orderId, overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                      Text('\u{20B9}${widget.order.totalPrice}'),
                      Text(
                        widget.order.address,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.order.phoneNumber,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                // width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        widget.order.product.images[0],
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.order.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Qty: ${widget.order.quantity}',
                          ),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Stepper(
                  physics: const NeverScrollableScrollPhysics(),
                  currentStep: currentStep,
                  controlsBuilder: ((context, details) {
                    if (user.type != 'user' &&
                        user.id == widget.order.product.userid!) {
                      return CommonButton(
                        onTap: () {
                          if (currentStep < 3) {
                            AdminServices().updateStatus(
                                context: context,
                                order_id: widget.order.orderId,
                                onSucess: () {
                                  setState(
                                    () {
                                      currentStep += 1;
                                      print(currentStep);
                                    },
                                  );
                                });
                          }
                        },
                        buttonText: 'Done',
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  steps: [
                    Step(
                      title: const Text('Order Placed'),
                      content: const Text(
                        'Your order is yet to be delivered',
                      ),
                      isActive: currentStep >= 0,
                      state: currentStep >= 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Order dispatched'),
                      content: const Text(
                        'Your order has been dispatched by seller who sends lots of love with it.',
                      ),
                      isActive: currentStep >= 1,
                      state: currentStep >= 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Reached at your city'),
                      content: const Text(
                        'Your order has reached your city and will be delivered to you soon.',
                      ),
                      isActive: currentStep >= 2,
                      state: currentStep >= 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Your order has reached you successfully!',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ]),
              const SizedBox(
                height: 10,
              ),
              CommonButton(
                onTap: () async {
                  await cancelOrder(
                    currentStep,
                    widget.order.paymentMode,
                    widget.order.orderId,
                  );
                },
                buttonText: currentStep < 3 ? 'Cancel Order' : 'Return Order',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
