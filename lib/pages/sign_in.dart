import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/fade_in_navigation.dart';
// import 'package:provider/provider.dart';
// import 'package:redbull_code_bech_v1/forms/forms.dart';
// import 'package:redbull_code_bech_v1/helpers/validators.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/provider/google_sign_in.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';
// import 'package:redbull_code_bech_v1/widgets/widgets.dart';
import 'package:flutter_login/flutter_login.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({Key? key}) : super(key: key);

  Future<String?> _authUser(LoginData data) async {
    // print('Name: ${data.name}, Password: ${data.password}');

    final response = await AuthenticationService.signInWithEmailAndPassword(
        data.name, data.password);
    if (response == null) {
      return 'User not exists';
    }

    return null;
  }

  Future<String?> _createUser(SignupData data) async {
    // print('Name: ${data.name}, Password: ${data.password}');

    final response = await AuthenticationService.createUserWithEmailAndPassword(
        data.name, data.password);
    if (response == null) {
      return 'User not exists';
    }

    return null;
  }

  Future<String?> _restartPassword(email) async {
    await AuthenticationService.restartPassword(email);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: 'assets/red-bull-code-app-icon.png',
      onLogin: _authUser,
      onSignup: _createUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacement(
          context,
          fadeInNavigation(
            context,
            const HomePage(),
          ),
        );
      },
      onRecoverPassword: _restartPassword,
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.apple,
          label: 'Apple',
          callback: () async {
            debugPrint('start google sign in');
            debugPrint('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
            icon: FontAwesomeIcons.google,
            label: 'Google',
            callback: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.googleLogin();
              // final user = FirebaseAuth.instance.currentUser!;
              return null;
            })
      ],
      messages: LoginMessages(
        userHint: 'Correo',
        additionalSignUpFormDescription: "asd",
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Repetir Contraseña',
        loginButton: 'Ingresar',
        signupButton: 'Registrarse',
        forgotPasswordButton: 'Olvidaste tu contraseña?',
        recoverPasswordIntro: "Recuperar contraseña",
        recoverPasswordButton: 'Enviar',
        goBackButton: 'Volver',
        confirmPasswordError: 'Contraseña erronea !',
        recoverPasswordDescription:
            'Ingresa tu correo y te enviaremos un link para que puedas restablecer tu contraseña',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}
