import 'package:ecommerce_webapp/features/home_screen.dart/services/home_services.dart';
import 'package:ecommerce_webapp/features/product_details/screens/product_details_screen.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDeal();
  }

  fetchDeal() async {
    // print('calling the fetch deals of day api');
    product = await HomeServices().fetchDealOfTheDay(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                child: const Text('Deal of the day',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              ),
              product!.name.isEmpty
                  ? const SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Center(
                        child: Text('No deal'),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductDetailsScreen(product: product!);
                        }));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(product!.images[0],
                              width: MediaQuery.of(context).size.width,
                              height: 235,
                              fit: BoxFit.contain),
                          Container(
                            // alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('\$ ${product!.price.toString()}',
                                style: const TextStyle(fontSize: 18)),
                          ),
                          Container(
                            // alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 15, right: 40),
                            child: Text(
                              product!.name,
                              // style:TextStyle(fontSize:18, fontWeight:FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //now we see all the images of the product in a row
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: product!.images
                                    .map(
                                      (e) => (Builder(
                                        builder: (context) {
                                          return Image.network(
                                            e,
                                            fit: BoxFit.contain,
                                            height: 100,
                                            width: 100,
                                          );
                                        },
                                      )),
                                    )
                                    .toList()),
                          ),
                          Container(
                            // alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(
                                left: 15, top: 15, bottom: 15),
                            child: const Text(
                              'See all deals',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 165, 29),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          );
  }
}
