import 'package:flutter/material.dart';

const domain="https://sahaj-amazon.onrender.com";
// const domain="http://localhost:4999";

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(202, 255, 153, 0),
      Color.fromARGB(200, 228, 169, 5),
    ],
    stops: [0.5, 1.0],
  );
  static const appBarGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(202, 255, 153, 0),
      Color.fromARGB(255, 255, 255, 255),
    ],
    // stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 221, 129, 8);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const selectedNavBarColor =Colors.orange;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES


  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Pottery',
      'image': 'assets/images/1.png',
    },
    {
      'title': 'Embroidery',
      'image': 'assets/images/2.png',
    },
    {
      'title': 'Jewelry',
      'image': 'assets/images/3.png',
    },
    {
      'title': 'Paintings',
      'image': 'assets/images/4.png',
    },
    {
      'title': 'Sculptures',
      'image': 'assets/images/5.png',
    },
  ];
}