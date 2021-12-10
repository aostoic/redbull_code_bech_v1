import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/colors.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GamePage extends HookWidget {
  static String routeName = '/game';

  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final service = Provider.of<GameService>(context);
    final Game game = service.currentGame!;

    final tournamentService = Provider.of<TournamentService>(context);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        tournamentService.getTournamentsByGame(game.id);
      });
    }, []);

    final tournaments = tournamentService.tournamentsByGame;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Column(
        children: [
          Hero(
            tag: game.id,
            child: Container(
              width: double.infinity,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    game.portraitUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          _TournamentsList(
            tournaments: tournaments,
          ),
        ],
      ),
    );
  }
}

class _TournamentsList extends StatelessWidget {
  final List<Tournament> tournaments;

  const _TournamentsList({
    Key? key,
    required this.tournaments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _getCircleColor(String status) {
      if (status == 'inProgress') {
        return AppColors.tournamentInProgress;
      } else if (status == 'finished') {
        return AppColors.tournamentFinished;
      } else {
        return AppColors.tournamentWaiting;
      }
    }

    IconData _getStatusIcon(String status) {
      if (status == 'inProgress') {
        return FontAwesomeIcons.gamepad;
      } else if (status == 'finished') {
        return FontAwesomeIcons.trophy;
      } else {
        return FontAwesomeIcons.clock;
      }
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => _TournamentListTile(
        tournament: tournaments[index],
        circleColor: _getCircleColor(tournaments[index].status),
        statusIcon: _getStatusIcon(tournaments[index].status),
      ),
      itemCount: tournaments.length,
    );
  }
}

class _TournamentListTile extends StatelessWidget {
  final Tournament tournament;
  final Color circleColor;
  final IconData statusIcon;

  const _TournamentListTile({
    Key? key,
    required this.tournament,
    required this.circleColor,
    required this.statusIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(
      context,
    );

    void _handleDeletePatient(String id) async {
      await tournamentService.deleteTournament(id);
    }

    return Dismissible(
      key: Key(tournament.id),
      onDismissed: (_) => _handleDeletePatient(tournament.id),
      movementDuration: const Duration(milliseconds: 200),
      background: Container(
        alignment: Alignment.centerRight,
        width: double.infinity,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              tournament.title,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.disabledColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tournament.status,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.disabledColor,
                  ),
                ),
                Text(
                  "Jugadores inscritos: ${tournament.players.length}",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.disabledColor,
                  ),
                ),
              ],
            ),
            leading: SizedBox(
              width: 60,
              height: 100,
              child: CircleAvatar(
                backgroundColor: circleColor,
                child: Icon(
                  statusIcon,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () => {},
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
