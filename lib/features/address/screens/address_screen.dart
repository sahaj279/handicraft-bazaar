import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/features/address/services/address_services.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';

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
  List<PaymentItem> paymentItems = [];
  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  String addressToBeUsed = "";
  final addressServices = AddressServices();
  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');

    paymentItems.add(PaymentItem(
      amount: widget.totalAmount.toString(),
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
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
    //so if the payment was suxxessful, we want to store the address in the provider if there was no address earlier
    print('#1');
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty || Provider.of<UserProvider>(context, listen: false)
        .user
        .address!=addressToBeUsed) {
          print('#2');
      await addressServices.saveUserAddress(context, addressToBeUsed);
    }
    print('#6');

    await addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalPrice: widget.totalAmount);
  }

  onGoogePaymentResult(res) {
    //so if the payment was suxxessful, we want to store the address in the provider if there was no address earlier
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(context, addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalPrice: widget.totalAmount);
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
    // UpiIndia _upiIndia = UpiIndia();
    // UpiApp app = UpiApp.googlePay;

    // address =
    //     "sahfdsfadsfadfadfasdfafadgadf daf df adg asd adf adga dff adg asdf adsf daff adgf asdf dg";
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
      body: Container(
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
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(address,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis)),
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
                        hintText: 'Flat, House No, Building', c: hnoController),
                    const SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                        hintText: 'Area, Street', c: areaController),
                    const SizedBox(
                      height: 10,
                    ),
                    CommonTextField(hintText: 'Pincode', c: pincodeController,keyboardType: TextInputType.number,),
                    const SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                        hintText: 'Town/City', c: towncityController),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),CommonButton(
                      onTap: () {
                        payPressed(address);
                        onPaymentResult();
                      },
                      buttonText: 'Using gpay',
                      color: Colors.white,
                    )
                  // FutureBuilder<PaymentConfiguration>(
                  //     future: _googlePayConfigFuture,
                  //     builder: (context, snapshot) => snapshot.hasData
                  //         ? GooglePayButton(
                  //             onPressed: () {
                  //               payPressed(address);
                  //             },
                  //             height: 50,
                  //             paymentConfiguration: snapshot.data!,
                  //             paymentItems: paymentItems,
                  //             type: GooglePayButtonType.buy,
                  //             margin: const EdgeInsets.only(top: 15.0),
                  //             onPaymentResult: onGoogePaymentResult,
                  //             loadingIndicator: const Center(
                  //               child: CircularProgressIndicator(),
                  //             ),
                  //           )
                  //         : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
