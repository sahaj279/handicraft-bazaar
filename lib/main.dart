import 'package:ecommerce_webapp/features/authentication/authServices.dart';
import 'package:ecommerce_webapp/features/authentication/auth_page.dart';
import 'package:ecommerce_webapp/features/menu/screens/loading_screen.dart';
import 'package:ecommerce_webapp/pages/bottom_bar.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/admin/pages/admin_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider()), 
    // ChangeNotifierProvider(create: ((context) => ProductProvider()))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        debugShowCheckedModeBanner: false,
        title: 'Handicraft Bazaar',
        theme: ThemeData(
          // useMaterial3: true,
          fontFamily: "Oswald",
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.orange,
        ),
        //loading screen gets pushed here and we move further only after we've got some dta from the api
        home: const MenuScreenPage(), 
            // Provider.of<UserProvider>(context).user.token.isEmpty
            // ? const AuthPage()
            // : Provider.of<UserProvider>(context).user.type=='user'? const BottombarPage():const AdminPage()
            );
  }
}
