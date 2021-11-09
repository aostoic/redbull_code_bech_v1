import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/trophy.jpg"),
            fit: BoxFit.contain,
          ),
        ),
        child: null,
      ),
    );
  }
}
