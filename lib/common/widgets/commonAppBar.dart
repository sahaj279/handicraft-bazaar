import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 201, 192),
        elevation: 0,
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/amazon_in.png',
                color: Colors.black,
                width: 120,
                height: 45,
              ),
            ),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children:const [
                  Padding(
                    padding: EdgeInsets.only(right:15.0),
                    child: Icon(Icons.notifications_outlined,color: Colors.black,),
                  ), 
                  Icon(Icons.search,color: Colors.black,)
                ],
              )

            ),
          ],
        ),
      ),
    );
  }
}
