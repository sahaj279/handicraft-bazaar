import 'package:ecommerce_webapp/common/widgets/ratings_stars.dart';
import 'package:ecommerce_webapp/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchedProductWidget extends StatelessWidget {
  
  final Product product;
  const SearchedProductWidget({super.key, required this.product});

   

  @override
  Widget build(BuildContext context) {

   double avgRating=0;
    double totalRating=0;
    for(int i=0;i<product.ratings!.length;i++){
      totalRating+=product.ratings![i].rating;
      
    }
    if(totalRating!=0){
      avgRating=totalRating/product.ratings!.length;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
      child: Row(
        children: [
          Image.network(
            product.images[0],
            fit: BoxFit.fitHeight,
            height: 135,
            width: 135,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 22),
                ),
                 Stars(rating: avgRating),
                Text(
                  '\$${product.price.toString()}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text('Eligible for FREE Shipping'),
                const Text(
                  'in Stock',
                  style: TextStyle(color: Colors.orangeAccent),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
