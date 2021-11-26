import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/fade_in_navigation.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlayerHeader(player: authService.user!),
            const SizedBox(height: 10),
            PlayerProfileOptions(player: authService.user!),
          ],
        ),
      ),
    );
  }
}

class PlayerProfileOptions extends StatelessWidget {
  final User player;

  const PlayerProfileOptions({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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

    void goToPage(String routeName) {
      Navigator.of(context).pushNamed(routeName);
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => goToPage(MyTournamentsPage.routeName),
            leading: const Icon(
              FontAwesomeIcons.trophy,
              color: AppColors.backgroundDarkColor,
            ),
            title: const Text(
              'Mis torneos',
              style: TextStyle(
                color: AppColors.backgroundDarkColor,
                fontFamily: 'Ubuntu',
              ),
            ),
            trailing: const Icon(
              FontAwesomeIcons.arrowCircleRight,
              color: AppColors.backgroundDarkColor,
            ),
          ),
          const Divider(color: AppColors.backgroundDarkColor),
          ListTile(
            onTap: () => handleLogout(),
            leading: const Icon(
              FontAwesomeIcons.signOutAlt,
              color: AppColors.backgroundDarkColor,
            ),
            title: const Text(
              'Cerrar Sesión',
              style: TextStyle(
                color: AppColors.backgroundDarkColor,
                fontFamily: 'Ubuntu',
              ),
            ),
            trailing: const Icon(
              FontAwesomeIcons.arrowCircleRight,
              color: AppColors.backgroundDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}
