import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/colors.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyTournamentsPage extends StatelessWidget {
  static String routeName = '/my-tournaments';

  const MyTournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    final tournamentService = Provider.of<TournamentService>(
      context,
      listen: false,
    );

    void goToTournament(Tournament tournament) {
      tournamentService.currentTournament = tournament;
      Navigator.of(context).pushNamed(TournamentPage.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Torneos'),
      ),
      body: FutureBuilder(
        future: tournamentService.getMyTournaments(authService.user!.uid),
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
          if (snapshot.connectionState == ConnectionState.done) {
            final List tournaments = snapshot.data! as List;
            final List<String> titles = [
              for (int i = 0; i < tournaments.length; i++) tournaments[i].title,
            ];

            final List<Widget> images = [
              for (int i = 0; i < tournaments.length; i++)
                Hero(
                  tag: tournaments[i].id,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(
                          tournaments[i].urlImage,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ];

            return VerticalCardPager(
              titles: titles, // required
              images: images, // required
              textStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
              onPageChanged: (page) {},
              onSelectedItem: (index) => goToTournament(
                tournaments[index],
              ),
              initialPage: 0,
              align: ALIGN.CENTER,
            );

            // print(data);
          }
          return Container();
        },
      ),
    );
  }
}
