import 'dart:convert';

import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/features/address/services/address_services.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../common/widgets/CommonTextField.dart';
import '../../../common/widgets/common_button.dart';
import '../../../constants/global_constants.dart';

class AddressScreen extends StatefulWidget {
  final double totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final addressKey = GlobalKey<FormState>();
  final hnoController = TextEditingController();
  final areaController = TextEditingController();
  final pincodeController = TextEditingController();
  final towncityController = TextEditingController();
  String addressToBeUsed = "";
  final addressServices = AddressServices();
  bool processingPayment = false;

  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      // var gpay = const PaymentSheetGooglePay(
      //   merchantCountryCode: "IN",
      //   currencyCode: "INR",
      //   testEnv: true,
      // );
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Handicraft Bazaar'))
          .then((value) {});
      // var res = await Stripe.instance.initPaymentSheet(
      //     paymentSheetParameters: SetupPaymentSheetParameters(
      //   paymentIntentClientSecret: paymentIntent!['client_secret'],
      //   style: ThemeMode.dark,
      //   merchantDisplayName: "Handicraft Bazaar",
      //   // googlePay: gpay,
      // ));
      // print('#### res $res');
      displayPaymentSheet();
    } catch (e) {
      print('#### 3 ${e.toString()}');
      showSnackbar(context: context, content: e.toString());
    }
  }

  void displayPaymentSheet() async {
    try {
      // await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.presentPaymentSheet().then((value) {
        showSnackbar(
            context: context, content: 'Payment Successful, placing order...');
        onPaymentResult();

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } catch (e) {
      print('#### 2 ${e.toString()}');
      showSnackbar(context: context, content: e.toString());
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": '${widget.totalAmount.toInt() * 100}',
        "currency": "INR",
      };
      print('sending request');
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51O6ZnASFNECxEmGB1YtXerZZ0I0vVrvwvTk9LRMDJI33rTYhCNvNhZiQIDXEpV4r0xMORrjxypFR4VQ1l3AHKv5G00H4yxbyz9",
            "Content-Type": "application/x-www-form-urlencoded",
          });
      print('#### ${json.decode(response.body)}');
      return json.decode(response.body);
    } catch (e) {
      print('#### 1 ${e.toString()}');
      showSnackbar(context: context, content: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    hnoController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    towncityController.dispose();
  }

  onPaymentResult() async {
    processingPayment = true;
    setState(() {});
    //so if the payment was suxxessful, we want to store the address in the provider if there was no address earlier
    print('#1');
    if (Provider.of<UserProvider>(context, listen: false)
            .user
            .address
            .isEmpty ||
        Provider.of<UserProvider>(context, listen: false).user.address !=
            addressToBeUsed) {
      print('#2');
      await addressServices.saveUserAddress(context, addressToBeUsed);
    }
    print('#6');

    await addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalPrice: widget.totalAmount);
    processingPayment = false;
    setState(() {});
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = hnoController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        towncityController.text.isNotEmpty;
    //checking if any of the field was empty
    if (isForm) {
      if (addressKey.currentState!.validate()) {
        addressToBeUsed =
            '${hnoController.text}, ${areaController.text}- ${pincodeController.text}, ${towncityController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackbar(context: context, content: 'Enter Address First!');
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = Provider.of<UserProvider>(context).user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 235, 131, 14),
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: processingPayment
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    address.isNotEmpty
                        ? Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  address,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'OR',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
                    Form(
                      key: addressKey,
                      child: Column(
                        children: [
                          CommonTextField(
                            hintText: 'Flat, House No, Building',
                            c: hnoController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextField(
                            hintText: 'Area, Street',
                            c: areaController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextField(
                            hintText: 'Pincode',
                            c: pincodeController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextField(
                            hintText: 'Town/City',
                            c: towncityController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                      onTap: () {
                        payPressed(address);
                        makePayment();
                        // onPaymentResult();
                      },
                      buttonText: 'PROCEED',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
