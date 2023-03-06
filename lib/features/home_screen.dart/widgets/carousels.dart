import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselsView extends StatelessWidget {
  const CarouselsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [Image.asset('assets/images/11.png',fit: BoxFit.fitWidth,),
        Image.asset('assets/images/12.png',fit: BoxFit.fitWidth,),
        Image.asset('assets/images/13.png',fit: BoxFit.fitWidth,),]

                    
            ,
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));
  }
}
