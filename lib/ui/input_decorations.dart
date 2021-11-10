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
          color: AppColors.purpleDarkColor,
          width: 2,
        ),
      ),
      hintText: hinText,
      hintStyle: TextStyle(
        color: AppColors.inputLabelTextColor,
        fontFamily: 'Ubuntu',
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: AppColors.inputLabelTextColor,
        fontFamily: 'Ubuntu',
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: AppColors.purpleDarkColor,
              size: 30,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(suffixIcon, size: 30),
              color: AppColors.purpleDarkColor,
              onPressed:
                  suffixIconOnPress != null ? () => suffixIconOnPress() : null,
            )
          : null,
    );
  }
}
