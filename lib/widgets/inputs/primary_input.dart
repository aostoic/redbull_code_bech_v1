import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbull_code_bech_v1/ui/input_decorations.dart';

class PrimaryInput extends StatelessWidget {
  final TextInputType keyboardType;
  final String hinText;
  final String labelText;
  final IconData prefixIcon;
  final Function onChanged;
  final Function? validator;

  const PrimaryInput({
    Key? key,
    required this.keyboardType,
    required this.hinText,
    required this.labelText,
    required this.prefixIcon,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      autocorrect: false,
      keyboardType: keyboardType,
      decoration: InputDecorations.primaryInputDecoration(
        hinText: hinText,
        labelText: labelText,
        prefixIcon: prefixIcon,
      ),
      onChanged: (value) => onChanged(value),
      validator: (value) => validator != null ? validator!(value) : null,
      inputFormatters: [],
    );
  }
}
