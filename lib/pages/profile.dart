import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/fade_in_navigation.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationService = Provider.of<NavigationService>(context);
    final authService = Provider.of<AuthService>(context);

    void handleLogout() async {
      await authService.logout();

      Navigator.of(context).pushReplacement(
        fadeInNavigation(
          context,
          const SignInPage(),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1000), () {
        navigationService.selectedIndex = 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerHeader(player: authService.user!),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PrimaryButton(
              text: 'Cerrar Sesión',
              onPressed: () => handleLogout(),
            ),
          ),
        ],
      ),
    );
  }
}
