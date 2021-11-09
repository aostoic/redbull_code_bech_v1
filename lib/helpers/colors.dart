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
}
