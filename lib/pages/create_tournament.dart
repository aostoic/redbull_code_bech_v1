import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class CreateTournamentPage extends StatelessWidget {
  static String routeName = '/create-tournament';

  const CreateTournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear torneo'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => CreateTournamentForm(),
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
    final form = Provider.of<CreateTournamentForm>(context);

    void _submit() async {
      FocusScope.of(context).unfocus();

      if (!form.isValidForm()) {
        AppAlerts.showAlert(
          context,
          'Error',
          'Verifica los datos ingresados',
        );
        return;
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
                const UploadImageContainer(),
                PrimaryInput(
                  keyboardType: TextInputType.text,
                  hinText: 'Ingresa título...',
                  labelText: 'Título',
                  prefixIcon: FontAwesomeIcons.trophy,
                  onChanged: (value) => print(value),
                  validator: (String value) {
                    if (value.length < 8) {
                      return 'Ingresar mínimo 8 carácteres';
                    }

                    return null;
                  },
                ),
                PrimaryInput(
                  keyboardType: TextInputType.text,
                  hinText: 'Ingresa juego...',
                  labelText: 'Juego',
                  prefixIcon: FontAwesomeIcons.gamepad,
                  onChanged: (value) => print(value),
                  validator: (String value) {
                    if (value.length < 3) {
                      return 'Ingresa nombre de juego válido';
                    }

                    return null;
                  },
                ),
                PrimaryInput(
                  keyboardType: TextInputType.text,
                  hinText: 'Ingresa descripción...',
                  labelText: 'Descripción',
                  prefixIcon: FontAwesomeIcons.bookOpen,
                  onChanged: (value) => print(value),
                ),
                PrimaryInput(
                  keyboardType: TextInputType.number,
                  hinText: '0',
                  labelText: 'Cantidad de jugadores (4, 8 o 12)',
                  prefixIcon: FontAwesomeIcons.users,
                  onChanged: (value) => print(value),
                  validator: (String value) {
                    if (value != "4" && value != "8" && value != "12") {
                      return 'Ingresa 4, 8 o 12';
                    }

                    return null;
                  },
                ),
                PrimaryButton(
                  text: 'Crear torneo',
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

class UploadImageContainer extends StatelessWidget {
  const UploadImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage(
            'assets/trophy.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Text(
            'Subir portada de torneo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
              color: AppColors.inputLabelTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
