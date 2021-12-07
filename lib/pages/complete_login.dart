import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/home.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class CompleteLoginPage extends StatelessWidget {
  static String routeName = '/complete-login';

  const CompleteLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completar registro'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => CompleteLoginForm(),
        child: const _CreateForm(),
      ),
    );
  }
}

class _CreateForm extends StatelessWidget {
  const _CreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final form = Provider.of<CompleteLoginForm>(context);
    final authService = Provider.of<AuthService>(context);

    final userService = Provider.of<UserService>(
      context,
      listen: false,
    );

    void goToPage(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }

    void _submit() async {
      FocusScope.of(context).unfocus();

      if (!form.isValidForm()) {
        AppAlerts.showAlert(
          context,
          'Error',
          'Verifica los datos ingresados',
        );
        return;
      } else {
        final result =
            await userService.saveUser(authService.user!.uid, form.name);

        if (result) {
          goToPage(HomePage.routeName);
        }
      }
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      height: size.height * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.backgroundDarkColor,
      ),
      child: Form(
        key: form.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryInput(
                  keyboardType: TextInputType.text,
                  hinText: 'Ingresa tu nombre...',
                  labelText: 'Nombre',
                  prefixIcon: FontAwesomeIcons.trophy,
                  onChanged: (value) => form.name = value,
                  validator: (String value) {
                    if (value.length < 4) {
                      return 'Ingresar mínimo 4 carácteres';
                    }

                    return null;
                  },
                ),
                PrimaryButton(
                  text: 'Completar Perfil',
                  onPressed: () => _submit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
