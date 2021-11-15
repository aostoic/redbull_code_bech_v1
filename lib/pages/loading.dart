import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:rive/rive.dart';

class LoadingPage extends HookWidget {
  static String routeName = '/loading';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundDarkColor,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    color: AppColors.backgroundDarkColor,
                    padding: const EdgeInsets.all(50),
                    child: const RiveAnimation.asset(
                      'assets/rives/loader.riv',
                    ));
              } else if (snapshot.hasData) {
                return HomePage();
              } else if (snapshot.hasError) {
                return const Center(child: Text("asdsad"));
              } else {
                if (!SecureStorageKeys.hideOnBording) {
                  return OnboardingPage();
                } else {
                  return const SignInPage();
                }
              }
            }));
    // return Scaffold(
    //   backgroundColor: AppColors.backgroundDarkColor,
    //   body: Container(
    //     color: AppColors.backgroundDarkColor,
    //     padding: const EdgeInsets.all(50),
    //     child: const RiveAnimation.asset(
    //       'assets/rives/loader.riv',
    //     ),
    //   ),
    // );
  }
}
