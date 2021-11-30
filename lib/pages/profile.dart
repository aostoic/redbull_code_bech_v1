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
                // user card
                SimpleUserCard(
                  userName: authService.user!.email!,
                  userProfilePic: NetworkImage(
                    NetworkImages.defaultProfileImage1,
                  ),
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: FontAwesomeIcons.xRay,
                      iconStyle: IconStyle(),
                      title: 'Appearance',
                      subtitle: "Make Ziar'App yours",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.fingerprint,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: 'Privacy',
                      subtitle: "Lock Ziar'App to improve your privacy",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: 'Dark mode',
                      subtitle: "Automatic",
                      trailing: Switch.adaptive(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about Ziar'App",
                    ),
                  ],
                ),
                // You can add a settings title
                SettingsGroup(
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: FontAwesomeIcons.baby,
                      title: "Change email",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: FontAwesomeIcons.accessibleIcon,
                      title: "Delete account",
                      titleStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
