import 'package:flutter/cupertino.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';

class TournamentService extends ChangeNotifier {
  Tournament? _currentTournament;
  Tournament? get currentTournament => _currentTournament;

  set currentTournament(Tournament? value) {
    _currentTournament = value;
    notifyListeners();
  }

  List<Tournament> _tournaments = [
    Tournament(
      id: 'asd123',
      title: 'Mario Kart',
      description: 'Divertido juego de carreras',
      status: TournamentStatus.waiting,
      gameId: 'asdqwe13',
      tournamentCategory: TournamentCategory.single,
      urlImage: NetworkImages.marioKartPortrait,
      playersQuantity: 16,
      ownerId: "asdsa123123",
    ),
    Tournament(
      id: 'asd123asdjhfghj123',
      title: 'Fifa 2021',
      description: 'Juego de futbol competitivo',
      status: TournamentStatus.waiting,
      gameId: 'asdqwe13hj1238',
      tournamentCategory: TournamentCategory.single,
      urlImage: NetworkImages.fifa21Portrait,
      playersQuantity: 8,
      ownerId: "asdsa123123",
    ),
    Tournament(
      id: 'asd123asdjhfghj123asdsad1231',
      title: 'Super Smash bros',
      description: 'Juego de peleas competitivo',
      status: TournamentStatus.waiting,
      gameId: 'asdqwe13hj1238dsa213124',
      tournamentCategory: TournamentCategory.single,
      urlImage: NetworkImages.smashBrosPortrait,
      playersQuantity: 8,
      ownerId: "asdsa123123",
    ),
  ];
  List<Tournament> get tournaments => _tournaments;

  set tournaments(List<Tournament> values) {
    _tournaments = values;
    notifyListeners();
  }
}
