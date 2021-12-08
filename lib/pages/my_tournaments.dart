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

    void goToTournament(Tournament tournament) {
      tournamentService.currentTournament = tournament;
      Navigator.of(context).pushNamed(TournamentPage.routeName);
    }

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
            hinText: tournamentService.isLoading ? 'Buscando..' : 'Buscar...',
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
                : Container(),
      ),
    );
  }
}
