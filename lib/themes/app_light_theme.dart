import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

final appLightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: AppBarTheme(
    elevation: 3,
    color: AppColors.appBarColor,
    shadowColor: AppColors.appBarBottomShadowColor,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu',
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
);
