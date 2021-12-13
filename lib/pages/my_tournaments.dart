import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';
import 'package:redbull_code_bech_v1/ui/search_bar_input_decoration.dart';

class MyTournamentsPage extends HookWidget {
  static String routeName = '/my-tournaments';

  const MyTournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final tournamentService = Provider.of<TournamentService>(context);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        tournamentService.getMyTournaments(authService.user!.uid);
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          enabled: !tournamentService.isLoading,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w300,
          ),
          decoration: SearchBarInputDecoration.searchBarInputDecoration(
            hinText: tournamentService.isLoading
                ? 'Buscando..'
                : 'Buscar por título o estado...',
            labelText: 'Torneo',
          ),
          onChanged: (value) {
            tournamentService.searchTournamentsByText(value);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          CreateTournamentPage.routeName,
        ),
        backgroundColor: AppColors.backgroundDarkColor,
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: tournamentService.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : tournamentService.myTournaments.isEmpty
                ? const Center(
                    child: Text(
                      'Aún no has creado un torneo',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColors.backgroundDarkColor,
                      ),
                    ),
                  )
                : _SearchResultsContainer(
                    tournaments: tournamentService.searchText.isNotEmpty
                        ? tournamentService.filteredTournaments
                        : tournamentService.myTournaments,
                  ),
      ),
    );
  }
}

class _SearchResultsContainer extends StatelessWidget {
  final List<Tournament> tournaments;

  const _SearchResultsContainer({
    Key? key,
    required this.tournaments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(context);

    String getSearchResultText() {
      if (tournamentService.searchText.isEmpty) {
        return 'Mis torneos';
      } else {
        return 'Resultados: ${tournaments.length}';
      }
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            color: AppColors.backgroundColor,
            child: Text(
              getSearchResultText(),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.66,
            child: _TournamentsList(
              tournaments: tournaments,
            ),
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
      itemBuilder: (_, index) => _TournamentListTile(
        tournament: tournaments[index],
        circleColor: _getCircleColor(tournaments[index].status),
        statusIcon: _getStatusIcon(tournaments[index].status),
        statusText: _getStatusText(tournaments[index].status),
      ),
      itemCount: tournaments.length,
    );
  }
}

class _TournamentListTile extends StatelessWidget {
  final Tournament tournament;
  final Color circleColor;
  final IconData statusIcon;
  final String statusText;

  const _TournamentListTile({
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
