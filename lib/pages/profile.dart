import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/fade_in_navigation.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
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
        title: const Text('Mi Perfil'),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => handleLogout(),
                child: const Icon(FontAwesomeIcons.signOutAlt),
              )),
        ],
      ),
      body: Column(
        children: const [
          ProfileHeader(),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);

    return Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(
              NetworkImages.defaultProfileImage1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            authService.user!.email!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Ubuntu',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Partidas',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                FontAwesomeIcons.gamepad,
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Jugadas',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Ganadas',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Perdidas',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
