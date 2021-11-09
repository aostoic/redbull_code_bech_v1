import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:rive/rive.dart';

class LoadingPage extends StatelessWidget {
  static String routeName = '/loading';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future checkAuth() async {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          fadeInNavigation(
            context,
            const OnboardingPage(),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      body: FutureBuilder(
          future: checkAuth(),
          builder: (_, __) {
            return Container(
              color: AppColors.primaryDarkColor,
              padding: const EdgeInsets.all(50),
              child: const RiveAnimation.asset('assets/rives/loader.riv'),
            );
          }),
    );
  }
}
