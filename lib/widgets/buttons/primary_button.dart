import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final bool isLoading;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDisabled() {
      if (isLoading) {
        return true;
      }

      if (onPressed == null) {
        return true;
      }

      return false;
    }

    return MaterialButton(
      elevation: 0,
      color: AppColors.indigoDarkColor,
      minWidth: double.infinity,
      disabledColor: AppColors.disabledColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color:
              isDisabled() ? Colors.grey.shade200 : AppColors.indigoDarkColor,
        ),
      ),
      onPressed: isDisabled() ? null : () => onPressed!(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
