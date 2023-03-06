import 'package:ecommerce_webapp/constants/global_constants.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomChip({super.key, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        decoration: BoxDecoration(
          color: GlobalVariables.greyBackgroundCOlor,
          border: Border.all(width: 0, color: Colors.white),
          borderRadius: BorderRadius.circular(33),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: GlobalVariables.greyBackgroundCOlor,
            
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33) )),
            onPressed: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, ),
              ),
            )),
      ),
    );
  }
}
