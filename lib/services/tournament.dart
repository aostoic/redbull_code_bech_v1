import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:uuid/uuid.dart';

class TournamentService extends ChangeNotifier {
  final uuid = const Uuid();

  Tournament? _currentTournament;
  Tournament? get currentTournament => _currentTournament;

  set currentTournament(Tournament? value) {
    _currentTournament = value;
    notifyListeners();
  }

  List<Tournament> _tournaments = [];
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

  Future<void> getTournaments(String ownerId) async {
    try {
      isLoading = true;

      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.tournaments)
          .get();

      tournaments = Tournament.getListFromFirebase(result.docs);
    } catch (err) {
      print("getTournaments err: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }

  Future<void> getMyTournaments(String ownerId) async {
    try {
      isLoading = true;

      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.tournaments)
          .where('ownerId', isEqualTo: ownerId)
          .get();

      myTournaments = Tournament.getListFromFirebase(result.docs);
    } catch (err) {
      print("getMyTournaments err: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }

  Future<Tournament?> createTournament(String title, String description,
      int playersQuantity, String gameId, String ownerId) async {
    try {
      isLoading = true;

      final newId = uuid.v4();

      final Tournament newTournament = Tournament(
        id: newId,
        title: title,
        description: description,
        status: 'waiting',
        gameId: gameId,
        playersQuantity: playersQuantity,
        ownerId: ownerId,
      );

      await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.tournaments)
          .doc(newId)
          .set(newTournament.toJson());

      return newTournament;
    } catch (err) {
      print("createTournament error: ${err.toString()}");
      return null;
    } finally {
      isLoading = false;
    }
  }
}
