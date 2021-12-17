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

    Future<void> _goToViewMatch() async {
      Navigator.of(context).pushNamed(MapsOfGroupPage.routeName);
    }

    Future<void> _handleCancelSignUpTournament() async {
      await tournamentService.cancelSignUp(authService.user!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tournament.title),
        actions: <Widget>[
          if (tournament.ownerId == authService.user!.uid)
            PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {'Editar', 'Comenzar'}.map((String choice) {
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Descripción : ', textAlign: TextAlign.center),
            Text('${tournament.description}', textAlign: TextAlign.center),
            const SizedBox(height: 30),
            Text(
              'Jugadores inscritos: ${tournament.players.length} / ${tournament.playersQuantity}',
              style: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (tournament.status == 'waiting')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: PrimaryButton(
                text: 'Ver Mapa de Grupos',
                onPressed: () => _goToViewMatch(),
                isLoading: tournamentService.isLoading,
              ),
            ),
            PlayerList(players: tournament.players),
          ],
        ),
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final List<Player> players;

  const PlayerList({
    Key? key,
    required this.players,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Text(players[index].name);
        },
        itemCount: players.length,
      ),
    );
  }
}
