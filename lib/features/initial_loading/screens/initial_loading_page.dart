import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:ecommerce_webapp/common/widgets/circular_loader.dart';
import 'package:ecommerce_webapp/features/authentication/authServices.dart';

class InitialLoadingPage extends StatefulWidget {
  const InitialLoadingPage({super.key});

  @override
  State<InitialLoadingPage> createState() => _InitialLoadingPageState();
}

class _InitialLoadingPageState extends State<InitialLoadingPage> {
  final authService = AuthServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await authService.getUserData(context);
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularLoader(),
    );
  }
}
