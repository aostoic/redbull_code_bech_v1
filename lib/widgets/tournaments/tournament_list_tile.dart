import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';

class TournamentListTile extends StatelessWidget {
  final Tournament tournament;
  final Color circleColor;
  final IconData statusIcon;
  final String statusText;

  const TournamentListTile({
    Key? key,
    required this.tournament,
    required this.circleColor,
    required this.statusIcon,
    required this.statusText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(
      context,
    );

    void _handleDeletePatient(String id) async {
      await tournamentService.deleteTournament(id);
    }

    void _goToTournament(Tournament tournament) {
      tournamentService.currentTournament = tournament;
      Navigator.of(context).pushNamed(TournamentPage.routeName);
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
                  statusText,
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
            onTap: () => _goToTournament(tournament),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
