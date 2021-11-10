import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

final appDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.backgroundDarkColor,
  appBarTheme: AppBarTheme(
    elevation: 3,
    color: AppColors.appBarColor,
    shadowColor: AppColors.appBarBottomShadowColor,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ), // 1
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
);
