import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/services/services.dart';

class TournamentPage extends StatelessWidget {
  static String routeName = '/tournament';

  const TournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(context);
    final Tournament tournament = tournamentService.currentTournament!;

    return Scaffold(
      appBar: AppBar(
        title: Text(tournament.title),
      ),
    );
  }
}
