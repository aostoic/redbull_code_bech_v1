import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:redbull_code_bech_v1/pages/pages.dart';
import 'package:redbull_code_bech_v1/services/services.dart';

class TournamentsPage extends HookWidget {
  static String routeName = '/tournaments';

  const TournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final tournamentService = Provider.of<TournamentService>(context);

    final List<Tournament> tournaments = tournamentService.tournaments;

    useEffect(() {
      Future.delayed(Duration.zero, () {
        tournamentService.getTournaments(authService.user!.uid);
      });
    }, []);

    void goToTournament(Tournament tournament) {
      tournamentService.currentTournament = tournament;
      Navigator.of(context).pushNamed(TournamentPage.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos'),
      ),
    );
  }
}
