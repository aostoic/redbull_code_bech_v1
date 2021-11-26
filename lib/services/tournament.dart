import 'package:cloud_firestore/cloud_firestore.dart';
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
      status: "waiting",
      game: 'Mario Kart',
      urlImage: NetworkImages.marioKartPortrait,
      playersQuantity: 16,
      ownerId: "asdsa123123",
    ),
    Tournament(
      id: 'asd123asdjhfghj123',
      title: 'Fifa 2021',
      description: 'Juego de futbol competitivo',
      status: "waiting",
      game: 'Fifa 2021',
      urlImage: NetworkImages.fifa21Portrait,
      playersQuantity: 8,
      ownerId: "asdsa123123",
    ),
    Tournament(
      id: 'asd123asdjhfghj123asdsad1231',
      title: 'Super Smash bros',
      description: 'Juego de peleas competitivo',
      status: "waiting",
      game: 'Super Smash Bros',
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

  List<Tournament> _myTournaments = [];
  List<Tournament> get myTournaments => _myTournaments;

  set myTournaments(List<Tournament> values) {
    _myTournaments = values;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<Tournament>> getMyTournaments() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.tournaments)
          .get();

      return Tournament.getListFromFirebase(result.docs);
    } catch (err) {
      print("getMyTournaments err: ${err.toString()}");
      return [];
    }
  }
}
