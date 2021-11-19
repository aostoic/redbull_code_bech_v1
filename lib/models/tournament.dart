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
