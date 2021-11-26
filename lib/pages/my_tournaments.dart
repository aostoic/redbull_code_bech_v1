import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/colors.dart';
import 'package:redbull_code_bech_v1/services/services.dart';

class MyTournamentsPage extends StatelessWidget {
  static String routeName = '/my-tournaments';

  const MyTournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Torneos'),
      ),
      body: FutureBuilder(
        future: tournamentService.getMyTournaments(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Aún no has creado un torneo',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.backgroundDarkColor,
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
