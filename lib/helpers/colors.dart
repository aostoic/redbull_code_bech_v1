import 'package:flutter/material.dart';

class ColorFromHex extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  ColorFromHex(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColors {
  static const Color primaryColor = Color.fromRGBO(253, 124, 35, 1);
  static final Color disabledColor = ColorFromHex('#797A80');
  static final Color backgroundColor = ColorFromHex("#F0F0F2");

  static final Color appBarColor = ColorFromHex("#FFFFFF");
  static final Color appBarBottomShadowColor = ColorFromHex("#C2C3CC");

  // Dark colors
  static const Color backgroundDarkColor = Color.fromRGBO(49, 49, 49, 1);
  static const Color indigoDarkColor = Color.fromRGBO(89, 89, 239, 1);
  static const Color purpleDarkColor = Color.fromRGBO(177, 75, 251, 1);

  // Inputs
  static final Color inputLabelTextColor = ColorFromHex("#535867");
  static final Color unfocusedInputBorderColor = ColorFromHex("#292C33");

  // Social Colors
  static const Color facebookColor = Color(0xFF1877f2);

  // Tournament Status Color
  static const Color tournamentWaiting = Color.fromRGBO(255, 189, 36, 1);
  static const Color tournamentInProgress = Color.fromRGBO(34, 217, 63, 1);
  static const Color tournamentFinished = Color.fromRGBO(208, 44, 28, 1);
}
