import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:ecommerce_webapp/features/home_screen.dart/pages/category_deals_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context) {
             return  CategoryDeals(category: GlobalVariables.categoryImages[index]['title']!);
            },));},
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Text(GlobalVariables.categoryImages[index]['title']!,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
