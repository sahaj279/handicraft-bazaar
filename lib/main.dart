import 'package:ecommerce_webapp/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:ecommerce_webapp/features/initial_loading/screens/initial_loading_page.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Stripe.publishableKey =
  //     "pk_test_51O6ZnASFNECxEmGBeVGGTHlpL8jrLPOqOXSKmzwbgs5MS1R5ArdZlGZ2y4Vhx8qmWmKnCoPU4jVbrQT3WnBYtKu8004Rm20mA8";
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: ((context) => ProductProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Handicraft Bazaar',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Poppins",
        primarySwatch: Colors.orange,
      ),
      home: const InitialLoadingPage(),
    );
  }
}
