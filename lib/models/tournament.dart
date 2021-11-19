import 'package:redbull_code_bech_v1/helpers/helpers.dart';

enum TournamentStatus {
  waiting,
  isProgress,
  finished,
}

enum TournamentCategory {
  single,
  duo,
  team,
}

class Tournament {
  String id;
  String title;
  String description;
  TournamentStatus status;
  String gameId;
  TournamentCategory tournamentCategory;
  String urlImage;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.gameId,
    required this.tournamentCategory,
    required this.urlImage,
  });
}

List<Tournament> tournamentsDummyData = [
  Tournament(
    id: 'asd123',
    title: 'Mario Kart',
    description: 'Divertido juego de carreras',
    status: TournamentStatus.waiting,
    gameId: 'asdqwe13',
    tournamentCategory: TournamentCategory.single,
    urlImage: NetworkImages.marioKartPortrait,
  ),
  Tournament(
    id: 'asd123asdjhfghj123',
    title: 'Fifa 2021',
    description: 'Juego de futbol competitivo',
    status: TournamentStatus.waiting,
    gameId: 'asdqwe13hj1238',
    tournamentCategory: TournamentCategory.single,
    urlImage: NetworkImages.fifa21Portrait,
  ),
  Tournament(
    id: 'asd123asdjhfghj123asdsad1231',
    title: 'Super Smash bros',
    description: 'Juego de peleas competitivo',
    status: TournamentStatus.waiting,
    gameId: 'asdqwe13hj1238dsa213124',
    tournamentCategory: TournamentCategory.single,
    urlImage: NetworkImages.smashBrosPortrait,
  ),
];
