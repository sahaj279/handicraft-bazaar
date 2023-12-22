import 'package:ecommerce_webapp/common/util/snackbar.dart';
import 'package:ecommerce_webapp/features/admin/pages/admin_page.dart';
import 'package:ecommerce_webapp/features/authentication/auth_page.dart';
import 'package:ecommerce_webapp/features/profile/service/profile_service.dart';
import 'package:ecommerce_webapp/features/profile/widgets/custom_chip.dart';
import 'package:ecommerce_webapp/models/usermodel.dart';
import 'package:ecommerce_webapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ColumnRowWithChips extends StatelessWidget {
  const ColumnRowWithChips({super.key});

  static const String handiCraftEmail = 'HandiCraft@gmail.com';

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
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
              text: user.type == 'admin' ? 'Dashboard' : 'Turn Seller',
              onTap: () async {
                user.type == 'admin'
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
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'handicraft@gmail.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Whats your concern',
                  }),
                );
                if(await canLaunchUrl(emailLaunchUri)) {
                 await launchUrl(emailLaunchUri);
                }
                else{
                  showSnackbar(context: context, content: 'coudn\'t launch email');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
