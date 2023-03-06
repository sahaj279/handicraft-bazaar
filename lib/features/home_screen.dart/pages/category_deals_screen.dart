import 'package:ecommerce_webapp/features/home_screen.dart/services/home_services.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_constants.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../../profile/widgets/single_product.dart';

class CategoryDeals extends StatefulWidget {
  final String category;
  const CategoryDeals({super.key, required this.category});

  @override
  State<CategoryDeals> createState() => _CategoryDealsState();
}

class _CategoryDealsState extends State<CategoryDeals> {
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getProductsByCategory();
  }

  getProductsByCategory() async {
    HomeServices homeServices = HomeServices();
    products = await homeServices.getAllProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(widget.category,
              style: const TextStyle(color: Colors.black)),
        ),
      ),
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text('Keep shopping for ${widget.category}',
                      style: const TextStyle(fontSize: 20)),
                ),
                products!.isEmpty
                    ?const Expanded(
                      child:  Center(
                          child: Text('No Products for this category',
                              style: TextStyle(fontSize: 20)),
                        ),
                    )
                    : SizedBox(
                        height: 183,
                        child: GridView.builder(
                            padding: const EdgeInsets.only(left: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: products!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: ((context, index) {
                              Product productData = products![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsScreen(
                                          product: productData,
                                        );
                                      },
                                    ));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 140,
                                        child: SingleProduct(
                                            image: productData.images[0]),
                                      ),
                                      Text(
                                        productData.name,
                                        // style:const TextStyle(fontSize:14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
                      )
              ],
            ),
    );
  }
}
