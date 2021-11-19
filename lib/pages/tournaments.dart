import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class TournamentsPage extends StatelessWidget {
  static String routeName = '/tournaments';

  const TournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(context);
    final List<Tournament> tournaments = tournamentService.tournaments;

    void goToTournament(Tournament tournament) {
      tournamentService.currentTournament = tournament;
      Navigator.of(context).pushNamed(TournamentPage.routeName);
    }

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: VerticalCardPager(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
