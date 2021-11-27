import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';

class PlayerHeader extends StatelessWidget {
  final User player;

  const PlayerHeader({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      // height: size.height * 0.4,
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
          const SizedBox(height: 10),
          Text(
            player.email!,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Ubuntu',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const TournamentsPartHeader(),
          const SizedBox(height: 20),
          const GamesPartHeader(),
        ],
      ),
    );
  }
}

class TournamentsPartHeader extends StatelessWidget {
  const TournamentsPartHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Torneos',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ubuntu',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              FontAwesomeIcons.trophy,
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
                  'Jugados',
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
                  'Ganados',
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
                  'Perdidos',
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
    );
  }
}

class GamesPartHeader extends StatelessWidget {
  const GamesPartHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
