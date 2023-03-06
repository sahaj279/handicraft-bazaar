import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:flutter/material.dart';

errorHandle({required BuildContext context,required int statusCode,VoidCallback? onSuccess,String? snackbarcontent='Error in sending or receiving of request'}){
  if(statusCode==200){
    onSuccess!;
  }
  else{
    showSnackbar(context: context, content: snackbarcontent!);
  }
}