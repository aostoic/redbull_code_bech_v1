import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';

class OnboardingPage extends StatelessWidget {
  static String routeName = '/onboarding';

  final introKey = GlobalKey<IntroductionScreenState>();

  OnboardingPage({Key? key}) : super(key: key);

  Widget _buildImage(String assetName) =>
      Lottie.asset('assets/images/onboarding/$assetName');

  @override
  Widget build(BuildContext context) {
    void _onIntroEnd() {
      Navigator.pushReplacement(
        context,
        fadeInNavigation(
          context,
          const SignInPage(),
        ),
      );
    }

    const bodyStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Lato',
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );

    const titleStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Lato',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: AppColors.primaryDarkColor,
      imagePadding: EdgeInsets.all(20),
      imageFlex: 2,
      bodyFlex: 1,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: AppColors.primaryDarkColor,
      pages: [
        PageViewModel(
          title: "¡ Bienvenido a esta nueva experiencia !",
          body: "Donde podras gestionar tus futuros torneos",
          image: _buildImage('logo_1.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Inscribete a los torneos disponibles",
          body:
              "En los cuales podras participar y saber tu fecha de competición",
          image: _buildImage('logo_2.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Incluso organizar torneos regionales",
          body: "Ven y sumate a esta nueva experiencia",
          image: _buildImage('logo_3.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Se el campeón de tu area e incluso de tu pais",
          body: "Dale al click continuar y comencemos",
          image: _buildImage('logo_4.json'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(),
      skipFlex: 0,
      showSkipButton: true,
      nextFlex: 0,
      skip: const Text('Saltar', style: bodyStyle),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 30,
      ),
      done: const Text('Continuar', style: bodyStyle),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        activeColor: AppColors.purpleDarkColor,
      ),
    );
  }
}
