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
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          fadeInNavigation(
            context,
            OnboardingPage(),
          ),
        );
      });
    }, []);

    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      body: Container(
        color: AppColors.primaryDarkColor,
        padding: const EdgeInsets.all(50),
        child: const RiveAnimation.asset(
          'assets/rives/loader.riv',
        ),
      ),
    );
  }
}
