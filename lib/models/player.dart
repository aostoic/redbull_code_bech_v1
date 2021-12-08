class Player {
  String id;
  String name;

  Player({
    required this.id,
    required this.name,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  static List<Player> getListFromFirebase(List<dynamic> docs) => docs
      .map((e) => Player(
            id: e.id,
            name: e.data()['name'],
          ))
      .toList();
}
