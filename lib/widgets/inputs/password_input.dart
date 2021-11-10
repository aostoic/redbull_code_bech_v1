import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbull_code_bech_v1/helpers/validators.dart';
import 'package:redbull_code_bech_v1/ui/input_decorations.dart';

class PasswordInput extends StatefulWidget {
  final String labelText;
  final Function onChanged;

  const PasswordInput({
    Key? key,
    required this.labelText,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isObscure = true;

  void _handleShowPassword() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      obscureText: isObscure,
      decoration: InputDecorations.primaryInputDecoration(
        hinText: "******",
        labelText: widget.labelText,
        prefixIcon: Icons.lock_outline,
        suffixIcon: isObscure
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        suffixIconOnPress: () => _handleShowPassword(),
      ),
      onChanged: (value) => widget.onChanged(value),
      validator: (value) => AppValidators.isValidPassword(value!),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s")),
      ],
    );
  }
}
