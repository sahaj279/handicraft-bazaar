import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_webapp/common/widgets/common_button.dart';
import 'package:ecommerce_webapp/common/widgets/ratings_stars.dart';
import 'package:ecommerce_webapp/features/cart/pages/cart_screen_page.dart';
import 'package:ecommerce_webapp/features/product_details/services/product_details_services.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../search/screens/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double avgRating = 0;
  double myRating = 0;
  final produtDetailServices = ProductDetailsServices();

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRating += widget.product.ratings![i].rating;
      if (widget.product.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.ratings![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  void buyNow() async {
    await produtDetailServices.addToCart(
        context: context, product: widget.product);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const CartScreenPage();
    }));
  }

  void addToCart() async {
    await produtDetailServices.addToCart(
        context: context, product: widget.product);
  }

  void rateProduct(double rating) async {
    await produtDetailServices.rateProduct(
        context: context, product: widget.product, rating: rating);
  }

  onSearchTapped(String query) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SearchScreenHomePage(searchQuery: query);
      },
    ));
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.id!),
                      Stars(rating: avgRating),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.product.name,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            CarouselSlider.builder(
                itemCount: widget.product.images.length,
                itemBuilder: (context, index, realIndex) {
                  return Image.network(
                    widget.product.images[realIndex],
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.contain,
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  // height: 200,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  // autoPlayInterval: const Duration(seconds: 3),
                  // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            // Image.network(widget.product.images[0],height: MediaQuery.of(context).size.height/3,fit: BoxFit.contain,),
            Container(
              //acts as a divider
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.desc),
            ), // TODO: make a three dot icon at end which when clicked shows full desc else a dingle line
            Container(
              //acts as a divider
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonButton(onTap: buyNow, buttonText: 'Buy Now'),
                  const SizedBox(
                    height: 8,
                  ),
                  CommonButton(
                    onTap: addToCart,
                    buttonText: 'Add to Cart',
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
            Container(
              //acts as a divider
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Rate the product',
                style: TextStyle(fontSize: 22),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 0,
                maxRating: 5,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                glow: false,
                itemPadding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                itemBuilder: ((context, index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  );
                }),
                onRatingUpdate: ((rating) {
                  rateProduct(rating);
                }))
          ],
        ),
      ),
    );
  }
}
