import 'package:ecommerce_webapp/features/home_screen.dart/widgets/address_box.dart';
import 'package:ecommerce_webapp/features/product_details/screens/product_details_screen.dart';
import 'package:ecommerce_webapp/features/search/services/search_services.dart';
import 'package:ecommerce_webapp/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_constants.dart';
import '../../../models/product_model.dart';

class SearchScreenHomePage extends StatefulWidget {
  final bool? emptySearchQuery;
  final String searchQuery;
  const SearchScreenHomePage({
    super.key,
    required this.searchQuery,
    this.emptySearchQuery,
  });

  @override
  State<SearchScreenHomePage> createState() => _SearchScreenHomePageState();
}

class _SearchScreenHomePageState extends State<SearchScreenHomePage> {
  List<Product>? products;

  @override
  void initState() {
    fetchSearchedProducts();
    super.initState();
  }

  fetchSearchedProducts() async {
    products = await SearchServices().getSearchedProducts(
        context: context, searchQueryStirng: widget.searchQuery);
    setState(() {});
  }

  onSearchEntered(String query) async {
    if (query.trim() != '') {
      products = await SearchServices()
          .getSearchedProducts(context: context, searchQueryStirng: query);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        autofocus: widget.emptySearchQuery != null &&
                                widget.emptySearchQuery == true
                            ? true
                            : false,
                        onFieldSubmitted: onSearchEntered,
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
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                products!.isEmpty
                    ? Center(
                        child: Text(widget.emptySearchQuery != null &&
                                widget.emptySearchQuery == true
                            ? 'Enter a keyword to search.'
                            : 'No Product found for entered search keyword.'),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: products!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProductDetailsScreen(
                                        product: products![index]);
                                  },
                                ));
                              },
                              child: SearchedProductWidget(
                                  product: products![index]),
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
