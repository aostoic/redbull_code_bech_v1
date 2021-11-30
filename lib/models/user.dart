class User {
  String id;
  String name;
  String urlImage;
  String creationDate;

  User({
    required this.id,
    required this.name,
    required this.urlImage,
    required this.creationDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['UID'].toString(),
      name: json['DisplayName'].toString(),
      creationDate: json['CreationDate'].toString(),
      urlImage: json['Avatar'],
    );
  }
}
