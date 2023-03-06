
import 'package:flutter/material.dart';

showSnackbar({required BuildContext context,required String content}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

