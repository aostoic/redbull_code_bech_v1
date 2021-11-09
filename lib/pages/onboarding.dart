import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  static String routeName = '/onboarding';

  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('onboarding'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('onboarding'),
          ],
        ),
      ),
    );
  }
}
