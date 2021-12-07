import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/ui/input_decorations.dart';

class AppDropdownInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final List<Game> options;
  final String value;
  final Function onChanged;
  final IconData prefixIcon;

  const AppDropdownInput({
    Key? key,
    this.hintText = 'Please select an Option',
    required this.labelText,
    this.options = const [],
    required this.value,
    required this.onChanged,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecorations.primaryInputDecoration(
            hinText: hintText,
            labelText: labelText,
            prefixIcon: prefixIcon,
          ),
          isEmpty: value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isDense: true,
              onChanged: (value) => onChanged(value!),
              items: options.map((game) {
                return DropdownMenuItem(
                  value: game.id,
                  child: Text(game.name),
                );
              }).toList(),
            ),
          ),
        );
      },
      validator: (value) => value == "Select" ? 'Select an option' : null,
    );
  }
}
