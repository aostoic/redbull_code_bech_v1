import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';
import 'package:redbull_code_bech_v1/helpers/validators.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceder'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height * 1,
          child: ChangeNotifierProvider(
            create: (BuildContext context) => SignInFormProvider(),
            child: const _Form(),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInFormProvider = Provider.of<SignInFormProvider>(context);

    return Form(
      key: signInFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryInput(
              keyboardType: TextInputType.emailAddress,
              hinText: 'username@example.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.alternate_email,
              onChanged: (value) => print(value),
              validator: (value) => AppValidators.isValidEmail(value!),
            ),
            PasswordInput(
              labelText: 'Contraseña',
              onChanged: (value) => print(value),
            ),
            PrimaryButton(
              text: 'Acceder',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
