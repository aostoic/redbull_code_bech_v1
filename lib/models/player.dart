class Player {
  String id;
  String name;

  Player({
    required this.id,
    required this.name,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['UID'].toString(),
      name: json['DisplayName'].toString(),
    );
  }
}
