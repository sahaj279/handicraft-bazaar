import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
   CommonButton({super.key, required this.onTap, required this.buttonText,this.color, this.child});
  final VoidCallback onTap;
  final String buttonText;
  final Widget? child;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, 
      child:child?? Material(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: 50, 
          color:color ?? Colors.orange,
          child: Center(child: Text(buttonText),),
        ),
      ),
    );
  }
}