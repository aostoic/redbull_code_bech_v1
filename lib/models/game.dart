class Game {
  String id;
  String name;
  String type;
  String portraitUrl;

  Game({
    required this.id,
    required this.name,
    required this.type,
    required this.portraitUrl,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        portraitUrl: json["portraitUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "portraitUrl": portraitUrl,
      };

  static List<Game> getListFromFirebase(List<dynamic> docs) {
    List<Game> games = docs.map((e) {
      return Game(
        id: e.id,
        name: e["name"],
        type: e["type"],
        portraitUrl: e["portraitUrl"],
      );
    }).toList();

    return games;
  }
}
