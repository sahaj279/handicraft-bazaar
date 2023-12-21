import 'package:ecommerce_webapp/features/admin/pages/admin_page.dart';
import 'package:ecommerce_webapp/features/authentication/auth_page.dart';
import 'package:ecommerce_webapp/features/profile/service/profile_service.dart';
import 'package:ecommerce_webapp/features/profile/widgets/custom_chip.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColumnRowWithChips extends StatelessWidget {
  const ColumnRowWithChips({super.key});

  @override
  Widget build(BuildContext context) {
    String userType = Provider.of<UserProvider>(context).user.type;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChip(
              text: 'Your Orders',
              onTap: () {},
            ),
            CustomChip(
              text: userType == 'admin' ? 'Dashboard' : 'Turn Seller',
              onTap: () async {
                userType == 'admin'
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AdminPage())),
                        (route) => false)
                    : await ProfileService().turnSeller(context);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomChip(
              text: 'Log Out',
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.setString('x-auth-token', '');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthPage(),
                    ),
                    (route) => false);
              },
            ),
            CustomChip(
              text: 'Need Help?',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
