import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/forms/forms.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

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

    return Container(
      padding: const EdgeInsets.all(30),
      height: size.height * 1,
      child: Form(
        key: form.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              UploadImageContainer(),
            ],
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
