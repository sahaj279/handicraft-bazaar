

import 'package:ecommerce_webapp/common/widgets/circular_loader.dart';
import 'package:flutter/material.dart';

import '../../authentication/authServices.dart';

class MenuScreenPage extends StatefulWidget {
  const MenuScreenPage({super.key});

  @override
  State<MenuScreenPage> createState() => _MenuScreenPageState();
}

class _MenuScreenPageState extends State<MenuScreenPage> {
  final authService = AuthServices();

  @override
  void initState() {
    super.initState();
    getData();
    
  }
  getData()async{
    await authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularLoader(),
    );
  }
}