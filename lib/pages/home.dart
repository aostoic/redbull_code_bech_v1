import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/alerts.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/services/auth.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';

  HomePage({Key? key}) : super(key: key);
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('Bienvenido'),
        actions: [
          TextButton(
            child: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
            onPressed: () async {
              {
                final provider =
                    Provider.of<AuthenticationService>(context, listen: false);
                await provider.logout();

                // Navigator.of(context).pushNamed(SignInOptionsPage.routeName);

                // await FirebaseAuth.instance.authStateChanges();
              }
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.white,
              hoverColor: Colors.white,
              gap: 10,
              activeColor: Colors.white,
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor: Colors.grey,
              color: Colors.grey,
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.trophy,
                  text: 'Torneos',
                ),
                GButton(
                  icon: FontAwesomeIcons.gamepad,
                  text: 'En juego',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Perfil',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                // setState(() {
                _selectedIndex = index;
                // });
              },
            ),
          ),
        ),
      ),
    );
  }

  // void setState(Null Function() param0) {}
}
