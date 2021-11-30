import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';
import 'package:redbull_code_bech_v1/widgets/inputs/primary_input.dart';

class CompleteLoginPage extends StatelessWidget {
  static String routeName = '/complete-login';

  const CompleteLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completar Perfil'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const SizedBox(height: 10),]
            PrimaryInput(
                keyboardType: TextInputType.text,
                hinText: "Nombre",
                labelText: "Ingresa tu nombre",
                prefixIcon: FontAwesomeIcons.user,
                onChanged: () => {}),
            PrimaryInput(
                keyboardType: TextInputType.text,
                hinText: "Apellido",
                labelText: "Ingresa tu apellido",
                prefixIcon: FontAwesomeIcons.user,
                onChanged: () => {}),
            ElevatedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text('CONTAINED BUTTON'),
            )
            // PlayerProfileOptions(player: authService.user!),
          ],
        ),
      ),
    );
  }
}
