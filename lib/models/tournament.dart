import 'package:redbull_code_bech_v1/models/models.dart';

class Tournament {
  String id;
  String title;
  String description;
  String status;
  String gameId;
  int playersQuantity;
  String ownerId;
  List<String> winnerIds;
  List<Player> players;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
    this.status = 'waiting',
    required this.gameId,
    required this.playersQuantity,
    required this.ownerId,
    required this.winnerIds,
    required this.players,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        gameId: json["gameId"],
        playersQuantity: json["playersQuantity"],
        ownerId: json["ownerId"],
        winnerIds: json["winnerIds"],
        players: json["players"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "gameId": gameId,
        "playersQuantity": playersQuantity,
        "ownerId": ownerId,
        "winnerIds": winnerIds,
        "players": players,
      };

  static List<String> getWinnerIds(List<dynamic> docs) =>
      docs.map((e) => e.toString()).toList();

  static List<Tournament> getListFromFirebase(List<dynamic> docs) => docs
      .map((e) => Tournament(
            id: e.id,
            title: e.data()['title'],
            description: e.data()['description'],
            status: e.data()['status'],
            gameId: e.data()['gameId'],
            playersQuantity: e.data()['playersQuantity'],
            ownerId: e.data()['ownerId'],
            winnerIds: Tournament.getWinnerIds(e.data()['winnerIds']),
            players: Player.getListFromFirebase(e.data()['players']),
          ))
      .toList();
}
