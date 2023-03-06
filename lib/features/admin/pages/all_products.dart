import 'package:ecommerce_webapp/common/widgets/circular_loader.dart';
import 'package:ecommerce_webapp/features/admin/pages/add_product_screen.dart';
import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
import 'package:ecommerce_webapp/features/profile/widgets/single_product.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:ecommerce_webapp/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final adminServices = AdminServices();
  List<Product>? products;

  void deleteAProduct(String pid, String pname, VoidCallback onSuccess) async {
    await adminServices.deleteAProduct(
        context: context, productid: pid, pname: pname, onSuccess: onSuccess);
  }

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  void fetchAllProducts() async {
    products = await adminServices.getAllProducts(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // products= Provider.of<ProductProvider>(context).products;
    return Scaffold(
      body: products == null
          ? const CircularLoader()
          : GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                var productData = products![index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {}, //TODO show all details of this product
                        child: SizedBox(
                          height: 120,
                          child: SingleProduct(image: productData.images[0]),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  productData.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                                Text(
                                  '${productData.quantity} items left',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              deleteAProduct(productData.id!, productData.name,
                                  () {
                                products!.removeAt(index);
                                setState(() {});
                              });
                            }, //TODO show a dialog to confirm deletion
                            child: const Icon(
                              Icons.delete_outline,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a Product',
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                return const AddAProduct();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
