import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/alerts.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/provider/google_sign_in.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        actions: [
          TextButton(
            child: const Text(
              'Salir',
            ),
            onPressed: () async {
              {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                await provider.logout();

                // Navigator.of(context).pushNamed(SignInOptionsPage.routeName);

                // await FirebaseAuth.instance.authStateChanges();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user!.email!),
            PrimaryButton(
              text: 'Show alert',
              onPressed: () {
                AppAlerts.showAlert(
                  context,
                  'Redbull BECH App',
                  'Welcome to Redbull Bech App!',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
