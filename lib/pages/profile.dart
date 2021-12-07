import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                PlayerHeader(player: authService.user!),
                const SizedBox(height: 30),
                PlayerProfileOptions(player: authService.user!),
                // user card
              ],
            )));
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
      // height: size.height * 0.15,

      child: Column(
        children: [
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () => goToPage(MyTournamentsPage.routeName),
                icons: FontAwesomeIcons.trophy,
                titleStyle: TextStyle(
                  color: Colors.black,
                ),
                iconStyle: IconStyle(
                  backgroundColor: Colors.white,
                  iconsColor: Colors.black,
                ),
                title: 'Mis Torneos',
                subtitle: "my Tournaments",
                trailing: const Icon(
                  FontAwesomeIcons.arrowCircleRight,
                  color: AppColors.backgroundDarkColor,
                ),
              ),
            ],
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () => handleLogout(),
                icons: FontAwesomeIcons.signOutAlt,
                iconStyle: IconStyle(
                  backgroundColor: Colors.white,
                  iconsColor: Colors.black,
                ),
                titleStyle: TextStyle(
                  color: Colors.black,
                ),
                title: 'Cerrar Sesión',
                subtitle: "Sign out",
                trailing: const Icon(
                  FontAwesomeIcons.arrowCircleRight,
                  color: AppColors.backgroundDarkColor,
                ),
              ),
            ],
          ),
          // You can add a settings title
        ],
      ),
    );
  }
}
