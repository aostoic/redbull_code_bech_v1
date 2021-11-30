import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';

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
    final form = Provider.of<CreateTournamentForm>(context);

    return Form(
      key: form.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(),
    );
  }
}
