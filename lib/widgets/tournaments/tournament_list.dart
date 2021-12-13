import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/widgets/widgets.dart';

class TournamentsList extends StatelessWidget {
  final List<Tournament> tournaments;

  const TournamentsList({
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

    String _getStatusText(String status) {
      if (status == 'inProgress') {
        return 'En progreso';
      } else if (status == 'finished') {
        return 'Finalizado';
      } else {
        return 'En espera';
      }
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => TournamentListTile(
        tournament: tournaments[index],
        circleColor: _getCircleColor(tournaments[index].status),
        statusIcon: _getStatusIcon(tournaments[index].status),
        statusText: _getStatusText(tournaments[index].status),
      ),
      itemCount: tournaments.length,
    );
  }
}
