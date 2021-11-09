import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/alerts.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HomePage'),
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
