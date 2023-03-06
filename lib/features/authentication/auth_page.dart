// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/common/widgets/CommonTextField.dart';
import 'package:ecommerce_webapp/common/widgets/common_button.dart';
import 'package:ecommerce_webapp/features/admin/pages/admin_page.dart';
import 'package:ecommerce_webapp/features/authentication/authServices.dart';
import 'package:ecommerce_webapp/pages/bottom_bar.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

enum Auth { signup, login }

class _AuthPageState extends State<AuthPage> {
  final _sighupKey = GlobalKey<FormState>();
  final _loginKey = GlobalKey<FormState>();
  Auth auth = Auth.login;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signup() async {
    String s = await AuthServices().signup(
        _nameController.text, _passwordController.text, _emailController.text);
    showSnackbar(context: context, content: s);
  }

  void login() async {
    String s = await AuthServices()
        .login(_passwordController.text, _emailController.text, context);
        if(s=="2"){
          Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const BottombarPage();
      },
    ));
        }else if(s=="1"){
          Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const AdminPage();
      },
    ));
        }
    
    else{showSnackbar(context: context, content: s);}
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.orange,
        title: const Text('Handicraft Bazaar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              color: auth == Auth.login ? Colors.white : null,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        auth = Auth.login;
                      });
                    },
                    leading: Icon(auth == Auth.login
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    title: const Text('Login'),
                  ),
                  auth == Auth.login
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          child: Form(
                            key: _loginKey,
                            child: Column(
                              children: [
                                CommonTextField(
                                    hintText: 'Email', c: _emailController,keyboardType: TextInputType.emailAddress,),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonTextField(
                                    hintText: 'Password', c: _passwordController,obscureText: true,),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonButton(
                                    onTap: () {
                                      if (_loginKey.currentState!.validate()) {
                                        login();
                                      }
                                    },
                                    buttonText: 'LogIn')
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            //signup
            Container(
              margin: const EdgeInsets.all(5),
              color: auth == Auth.signup ? Colors.white : null,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        auth = Auth.signup;
                      });
                    },
                    leading: Icon(auth == Auth.signup
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off),
                    title: const Text('SignUp'),
                  ),
                  auth == Auth.signup
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Form(
                            key: _sighupKey,
                            child: Column(
                              children: [
                                CommonTextField(
                                    hintText: 'Name', c: _nameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonTextField(
                                    hintText: 'Email', c: _emailController,keyboardType: TextInputType.emailAddress,),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonTextField(
                                    hintText: 'Password', c: _passwordController,obscureText: true,),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonButton(
                                    onTap: () {
                                      if (_sighupKey.currentState!.validate()) {
                                        signup();
                                      }
                                    },
                                    buttonText: 'SignUp')
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
