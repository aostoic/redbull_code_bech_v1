import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

final appDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: AppBarTheme(
    elevation: 3,
    color: AppColors.backgroundDarkColor,
    shadowColor: AppColors.appBarBottomShadowColor,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu',
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ), // 1
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
);
