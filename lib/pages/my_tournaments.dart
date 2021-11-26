import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:redbull_code_bech_v1/services/services.dart';

class MyTournamentsPage extends HookWidget {
  static String routeName = '/my-tournaments';

  const MyTournamentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournamentService = Provider.of<TournamentService>(
      context,
      listen: false,
    );

    useEffect(() {
      tournamentService.getMyTournaments();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Torneos'),
      ),
    );
  }
}
