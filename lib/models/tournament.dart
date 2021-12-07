class Tournament {
  String id;
  String title;
  String description;
  String status;
  String gameId;
  int playersQuantity;
  String ownerId;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.gameId,
    required this.playersQuantity,
    required this.ownerId,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        gameId: json["gameId"],
        playersQuantity: json["playersQuantity"],
        ownerId: json["ownerId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "gameId": gameId,
        "playersQuantity": playersQuantity,
        "ownerId": ownerId,
      };

  static List<Tournament> getListFromFirebase(List<dynamic> docs) {
    List<Tournament> tournaments = docs.map((e) {
      return Tournament(
        id: e.id,
        title: e.data()['title'],
        description: e.data()['description'],
        status: e.data()['status'],
        gameId: e.data()['gameId'],
        playersQuantity: e.data()['playersQuantity'],
        ownerId: e.data()['ownerId'],
      );
    }).toList();

    return tournaments;
  }
}
