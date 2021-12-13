import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class EditTournamentPage extends StatelessWidget {
  static String routeName = '/edit-tournament';

  const EditTournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Torneo'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => EditTournamentForm(),
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
    final form = Provider.of<EditTournamentForm>(context);

    final gameService = Provider.of<GameService>(context, listen: false);
    final tournamentService = Provider.of<TournamentService>(context);
    final authService = Provider.of<AuthService>(context);

    final Tournament tournament = tournamentService.currentTournament!;

    // form.gameId = tournament.gameId;
    // form.title = tournament.title;

    useEffect(() {
      Future.delayed(Duration.zero, () {
        if (form.gameId.isEmpty) {
          form.gameId = gameService.games[0].id;
        }
        form.title = "asdasdas";
      });
    }, []);

    void _submit() async {}

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
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
      child: Center(
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
                    onChanged: (value) => form.title = value,
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
                    onChanged: (value) => form.description = value,
                    validator: (String value) {
                      if (value.length < 10) {
                        return 'Ingresar mínimo 10 caracteres';
                      }

                      return null;
                    },
                  ),
                  PrimaryInput(
                    keyboardType: TextInputType.number,
                    hinText: '0',
                    labelText: 'Cantidad de jugadores (4, 8 o 12)',
                    prefixIcon: FontAwesomeIcons.users,
                    onChanged: (String value) =>
                        form.playersQuantity = int.parse(value),
                    validator: (String value) {
                      if (value != "4" && value != "8" && value != "12") {
                        return 'Ingresa 4, 8 o 12';
                      }

                      return null;
                    },
                  ),
                  PrimaryButton(
                    text: 'Editar Torneo',
                    onPressed: () => _submit(),
                    isLoading: tournamentService.isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
