import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationService = Provider.of<NavigationService>(context);

    final List<Widget> _widgetOptions = <Widget>[
      const TournamentsPage(),
      const PlayersPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(
          navigationService.selectedIndex,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundDarkColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.white,
              hoverColor: Colors.white,
              gap: 10,
              activeColor: Colors.white,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 500),
              tabBackgroundColor: Colors.grey,
              color: Colors.grey,
              tabs: const [
                GButton(
                  icon: FontAwesomeIcons.trophy,
                  text: 'Torneos',
                ),
                GButton(
                  icon: FontAwesomeIcons.gamepad,
                  text: 'Jugadores',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Perfil',
                ),
              ],
              selectedIndex: navigationService.selectedIndex,
              onTabChange: (index) => navigationService.selectedIndex = index,
            ),
          ),
        ),
      ),
    );
  }
}
