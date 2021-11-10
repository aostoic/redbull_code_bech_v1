import 'package:flutter/material.dart';
import 'package:redbull_code_bech_v1/helpers/validators.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryInput(
            keyboardType: TextInputType.emailAddress,
            hinText: 'username@example.com',
            labelText: 'E-mail',
            prefixIcon: Icons.alternate_email,
            onChanged: (value) => print(value),
            validator: (value) => AppValidators.isValidEmail(value!),
          ),
          const SizedBox(height: 5),
          PasswordInput(
            labelText: 'Password',
            onChanged: (value) => print(value),
          ),
        ],
      ),
    );
  }
}
