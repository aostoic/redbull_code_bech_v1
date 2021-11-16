import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/fade_in_navigation.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    void handleLogout() async {
      await authService.logout();

      Navigator.of(context).pushReplacement(
        fadeInNavigation(
          context,
          const SignInPage(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => handleLogout(),
                child: const Icon(FontAwesomeIcons.signOutAlt),
              )),
        ],
      ),
      body: const Center(
        child: Text('ProfilePage'),
      ),
    );
  }
}
