import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_webapp/common/util/pick_images.dart';
import 'package:ecommerce_webapp/common/widgets/CommonTextField.dart';
import 'package:ecommerce_webapp/common/widgets/circular_loader.dart';
import 'package:ecommerce_webapp/common/widgets/common_button.dart';
import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/util/snackbar.dart';
import '../../../constants/global_constants.dart';

class AddAProduct extends StatefulWidget {
  const AddAProduct({super.key});

  @override
  State<AddAProduct> createState() => _AddAProductState();
}

class _AddAProductState extends State<AddAProduct> {
  final AdminServices _adminServices = AdminServices();
  final _productFormKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  bool load=false;
  String category = 'Pottery';
  List<Uint8List> images = [];

  List<String> productCategories = [
    'Pottery',
    'Embroidery',
    'Jewelry',
    'Paintings',
    'Sculptures'
  ];

  void selectImages() async {
    print("#1");
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _productNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text('Add Product',
                style: TextStyle(color: Colors.black))),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _productFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images
                            .map((i) => Builder(
                                builder: (context) => Image.memory(i,
                                    fit: BoxFit.cover, height: 200)))
                            .toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          scrollDirection: Axis.horizontal,
                        ))
                    : InkWell(
                        onTap: selectImages,
                        child: DottedBorder(
                          strokeWidth: 1.5,
                          dashPattern: const [5, 2],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(5),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.folder_open, size: 40),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select Prouct Images',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                    hintText: 'Product name', c: _productNameController),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  hintText: 'Description',
                  c: _descController,
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(hintText: 'Price', c: _priceController),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(hintText: 'Quantity', c: _quantityController),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        category = value!;
                      });
                    },
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonButton(
                    onTap: ()async {
                      if (_productFormKey.currentState!.validate() && images.isNotEmpty) {
                        setState(() {
                          load=true;
                        });
                       await _adminServices.sellProduct(
                            context: context,
                            name: _productNameController.text,
                            desc: _descController.text,
                            price: double.tryParse(_priceController.text)!,
                            quantity: int.tryParse(_quantityController.text)!,
                            images: images,
                            category: category);
                            setState(() {
                          load=false;
                        });
                      }else{
                        showSnackbar(context: context, content: 'Select images');
                      }
                    },
                    buttonText: 'Sell',
                    child:load?const CircularLoader():null,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
