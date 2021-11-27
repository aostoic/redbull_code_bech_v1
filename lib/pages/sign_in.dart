import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    Future<String?> handleSignInWithEmailAndPassword(LoginData data) async {
      final result = await authService.signInWithEmailAndPassword(
        data.name,
        data.password,
      );

      return result;
    }

    Future<String?> handleCreateUser(SignupData data) async {
      final result = await authService.createUserWithEmailAndPassword(
        data.name,
        data.password,
      );

      return result;
    }

    Future<String> restartPassword(email) async {
      return await authService.restartPassword(email);
    }

    Future<String> handleGoogleSignIn() async {
      return await authService.googleLogin();
    }

    Future<String> handleAppleSignIn() async {
      return await authService.signInWithApple();
    }

    void handleOnSubmitAnimationCompleted() {
      Navigator.pushReplacement(
        context,
        fadeInNavigation(
          context,
          const HomePage(),
        ),
      );
    }

    bool buttonView = false;

    if (kIsWeb) {
      buttonView = false;
    } else {
      if (Platform.isIOS) {
        buttonView = true;
      }
    }

    return FlutterLogin(
      title: 'RBC Team',
      logo: 'assets/red-bull-code-app-icon.png',
      onLogin: handleSignInWithEmailAndPassword,
      onSignup: handleCreateUser,
      onSubmitAnimationCompleted: () => handleOnSubmitAnimationCompleted(),
      onRecoverPassword: restartPassword,
      loginProviders: <LoginProvider>[
        if (buttonView)
          LoginProvider(
            icon: FontAwesomeIcons.apple,
            label: 'Apple',
            callback: () => handleAppleSignIn(),
          ),
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () => handleGoogleSignIn(),
        ),
      ],
      messages: LoginMessages(
        userHint: 'Correo',
        additionalSignUpFormDescription: "",
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Repetir Contraseña',
        loginButton: 'Ingresar',
        signupButton: '¡Registrarse!',
        forgotPasswordButton: '¿Olvidaste tu contraseña?',
        recoverPasswordIntro: "Recuperar contraseña",
        recoverPasswordButton: 'Enviar',
        goBackButton: 'Volver',
        confirmPasswordError: '¡Contraseña erronea!',
        recoverPasswordDescription:
            'Ingresa tu correo y te enviaremos un link para que puedas restablecer tu contraseña',
        recoverPasswordSuccess: '¡Contraseña recuperada con éxito!',
      ),
      theme: LoginTheme(
        primaryColor: AppColors.backgroundDarkColor,
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        buttonTheme: const LoginButtonTheme(),
      ),
    );
  }
}
