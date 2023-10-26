// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:ecommerce_webapp/common/widgets/CommonTextField.dart';
import 'package:ecommerce_webapp/common/widgets/common_button.dart';
import 'package:ecommerce_webapp/features/authentication/authServices.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

enum Auth {
  signUp,
  login,
}

class _AuthPageState extends State<AuthPage> {
  final _sighupKey = GlobalKey<FormState>();
  final _loginKey = GlobalKey<FormState>();
  Auth auth = Auth.login;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signup() async {
    await AuthServices().signup(
      _nameController.text,
      _passwordController.text,
      _emailController.text,
      context,
    );
  }

  void login() async {
    await AuthServices()
        .login(_passwordController.text, _emailController.text, context);
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
                    leading: Icon(
                      auth == Auth.login
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: auth == Auth.login ? Colors.orange : null,
                    ),
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
                                  hintText: 'Email',
                                  c: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonTextField(
                                  hintText: 'Password',
                                  c: _passwordController,
                                  obscureText: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonButton(
                                  onTap: () {
                                    if (_loginKey.currentState!.validate()) {
                                      login();
                                    }
                                  },
                                  buttonText: 'LogIn',
                                )
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
              color: auth == Auth.signUp ? Colors.white : null,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        auth = Auth.signUp;
                      });
                    },
                    leading: Icon(
                      auth == Auth.signUp
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: auth == Auth.signUp ? Colors.orange : null,
                    ),
                    title: const Text(
                      'SignUp',
                    ),
                  ),
                  auth == Auth.signUp
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Form(
                            key: _sighupKey,
                            child: Column(
                              children: [
                                CommonTextField(
                                  hintText: 'Name',
                                  c: _nameController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonTextField(
                                  hintText: 'Email',
                                  c: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonTextField(
                                  hintText: 'Password',
                                  c: _passwordController,
                                  obscureText: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CommonButton(
                                  onTap: () {
                                    if (_sighupKey.currentState!.validate()) {
                                      signup();
                                    }
                                  },
                                  buttonText: 'SignUp',
                                )
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
