import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

class SearchBarInputDecoration {
  static InputDecoration searchBarInputDecoration({
    required String hinText,
    required String labelText,
  }) {
    return InputDecoration(
      hintText: hinText,
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: AppColors.appBarBottomShadowColor,
        fontFamily: 'Ubuntu',
        fontSize: 22,
        fontWeight: FontWeight.w300,
      ),
      suffixIcon: const Icon(
        Icons.search,
        color: Colors.black,
        size: 40,
      ),
    );
  }
}
