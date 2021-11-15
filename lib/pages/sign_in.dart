import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/colors.dart';
import 'package:redbull_code_bech_v1/helpers/fade_in_navigation.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({Key? key}) : super(key: key);

  Future<String?> _authUser(LoginData data) async {
    final result =
        await AuthService.signInWithEmailAndPassword(data.name, data.password);

    return result;
  }

  Future<String?> _createUser(SignupData data) async {
    final result = await AuthService.createUserWithEmailAndPassword(
        data.name, data.password);

    return result;
  }

  Future<String?> _restartPassword(email) async {
    final result = await AuthService.restartPassword(email);
    return result;
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
            HomePage(),
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
            final provider = Provider.of<AuthService>(context, listen: false);
            final result = await provider.googleLogin();
            return result;
          },
        ),
      ],
      messages: LoginMessages(
        userHint: 'Correo',
        additionalSignUpFormDescription: "",
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
      theme: LoginTheme(
        primaryColor: AppColors.backgroundDarkColor,
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.yellow,
        ),
        buttonTheme: const LoginButtonTheme(),
      ),
    );
  }
}
