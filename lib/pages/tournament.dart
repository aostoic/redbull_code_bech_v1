import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/edit_tournament.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/buttons/primary_button.dart';

class TournamentPage extends StatelessWidget {
  static String routeName = '/tournament';

  const TournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(context);
    final Tournament tournament = tournamentService.currentTournament!;

    void handleClick(String value) {
      switch (value) {
        case 'Editar':
          Navigator.of(context).pushNamed(EditTournamentPage.routeName);
          break;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(tournament.title),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Editar'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: ListView(children: []));
  }
}
