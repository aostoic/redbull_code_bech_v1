import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/home.dart';
import 'package:redbull_code_bech_v1/provider/google_sign_in.dart';
import 'package:redbull_code_bech_v1/pages/sign_in.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';
import 'dart:io' show Platform;

class SignInOptionsPage extends StatelessWidget {
  static String routeName = '/sign-in-options';

  const SignInOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isIOS = Platform.isIOS;
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.9,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset('assets/red-bull-code-app-icon.png'),
                  ),
                  const Text(
                    'Redbull Code Team',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  SocialButton(
                      icon: FontAwesomeIcons.google,
                      color: Colors.red,
                      text: 'Acceder con Google',
                      onPressed: () async {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        await provider.googleLogin();
                        // await FirebaseAuth.instance.authStateChanges();
                        final user = FirebaseAuth.instance.currentUser!;
                        print(user);
                        Navigator.of(context).pushNamed(HomePage.routeName);
                      }),
                  const SizedBox(height: 10),
                  !isIOS
                      ? const SizedBox.shrink()
                      : SocialButton(
                          icon: FontAwesomeIcons.apple,
                          color: Colors.black,
                          text: 'Acceder con Apple',
                          onPressed: () {},
                        ),
                  const SizedBox(height: 15),
                  const Text(
                    'O',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  const SizedBox(height: 15),
                  PrimaryButton(
                    text: 'Acceder con credenciales',
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignInPage.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
