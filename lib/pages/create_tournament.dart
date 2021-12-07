import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
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

class _CreateForm extends HookWidget {
  const _CreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final form = Provider.of<CreateTournamentForm>(context);

    final gameService = Provider.of<GameService>(context);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        if (form.gameId.isEmpty) {
          form.gameId = gameService.games[0].id;
        }
      });
    }, []);

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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      height: size.height * 1,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Form(
        key: form.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (form.gameId.isNotEmpty)
                  AppDropdownInput(
                    labelText: 'Game',
                    hintText: "Game",
                    prefixIcon: FontAwesomeIcons.gamepad,
                    options: gameService.games,
                    value: form.gameId,
                    onChanged: (String value) => form.gameId = value,
                  ),
                PrimaryInput(
                  keyboardType: TextInputType.text,
                  hinText: 'Ingresa título...',
                  labelText: 'Título',
                  prefixIcon: FontAwesomeIcons.trophy,
                  onChanged: (value) => print(value),
                  validator: (String value) {
                    if (value.length < 5) {
                      return 'Ingresar mínimo 5 caracteres';
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
