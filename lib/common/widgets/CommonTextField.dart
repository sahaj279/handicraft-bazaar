import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController c;
  final int maxLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  const CommonTextField({super.key, required this.hintText, required this.c,this.maxLines=1, this.keyboardType,this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value){if(value=="" || value!.isEmpty){return "Enter $hintText";}},
      controller: c,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
