import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final firebaseService = Provider.of<FirebaseService>(context);
    final navigationService = Provider.of<NavigationService>(context);

    final List<Widget> _widgetOptions = <Widget>[
      const TournamentsPage(),
      //const PlayersPage(),
      const ProfilePage(),
      //const ProfilePage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(
          navigationService.selectedIndex,
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColors.backgroundDarkColor,
        activeColor: AppColors.appBarColor,
        color: AppColors.disabledColor,
        items: const [
          TabItem(icon: FontAwesomeIcons.trophy, title: 'Torneos'),
          //TabItem(icon: FontAwesomeIcons.gamepad, title: 'Activos'),
          TabItem(icon: FontAwesomeIcons.plus, title: 'Crear '),
          //TabItem(icon: FontAwesomeIcons.list, title: 'Finalizados'),
          TabItem(
            icon: FontAwesomeIcons.user,
            title: 'Perfil',
          ),
        ],
        initialActiveIndex: navigationService.selectedIndex,
        onTap: (index) => navigationService.selectedIndex = index,
      ),
    );
  }
}
