import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/widgets/buttons/primary_button.dart';

class TournamentPage extends StatelessWidget {
  static String routeName = '/tournament';

  const TournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final tournamentService = Provider.of<TournamentService>(context);
    final Tournament tournament = tournamentService.currentTournament!;

    final bool _isAlreadyRegistered = tournament.players
        .where((player) => player.id == authService.user!.uid)
        .toList()
        .isNotEmpty;

    void _handleClick(String value) {
      switch (value) {
        case 'Editar':
          Navigator.of(context).pushNamed(EditTournamentPage.routeName);
          break;
      }
    }

    Future<void> _handleSignUpTournament() async {
      await tournamentService.signUpTournament(authService.user!);
    }

    Future<void> _handleCancelSignUpTournament() async {
      await tournamentService.cancelSignUp();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tournament.title),
        actions: <Widget>[
          if (tournament.ownerId == authService.user!.uid)
            PopupMenuButton<String>(
              onSelected: _handleClick,
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
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Jugadores inscritos: ${tournament.players.length}',
              style: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: PrimaryButton(
                text: _isAlreadyRegistered
                    ? 'Cancelar inscripción'
                    : 'Inscribirme',
                onPressed: () => _isAlreadyRegistered
                    ? _handleCancelSignUpTournament()
                    : _handleSignUpTournament(),
                isLoading: tournamentService.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
