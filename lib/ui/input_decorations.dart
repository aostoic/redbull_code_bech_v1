import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

class InputDecorations {
  static InputDecoration primaryInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Function? suffixIconOnPress,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.disabledColor,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.indigoDarkColor,
          width: 2,
        ),
      ),
      hintText: hinText,
      hintStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Ubuntu',
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Ubuntu',
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: AppColors.indigoDarkColor,
              size: 30,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(suffixIcon, size: 30),
              color: AppColors.indigoDarkColor,
              onPressed:
                  suffixIconOnPress != null ? () => suffixIconOnPress() : null,
            )
          : null,
    );
  }
}
