import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:rive/rive.dart';

class LoadingPage extends HookWidget {
  static String routeName = '/loading';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    void goToPage(Widget page) {
      Navigator.of(context).pushReplacement(
        fadeInNavigation(context, page),
      );
    }

    Future<void> handleCheckAuth() async {
      final isAuthenticated = await authService.checkAuth();

      if (!isAuthenticated) {
        goToPage(OnboardingPage());
      } else {
        goToPage(HomePage());
      }
    }

    useEffect(() {
      handleCheckAuth();
    }, []);

    return Scaffold(
      backgroundColor: AppColors.backgroundDarkColor,
      body: Container(
        color: AppColors.backgroundDarkColor,
        padding: const EdgeInsets.all(50),
        child: const RiveAnimation.asset(
          'assets/rives/loader.riv',
        ),
      ),
    );
  }
}
