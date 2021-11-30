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
      _isLoading = true;

      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.tournaments)
          .get();

      final tournaments = Tournament.getListFromFirebase(result.docs);

      _tournaments = tournaments;
    } catch (err) {
      print("getTournaments err: ${err.toString()}");
    } finally {
      _isLoading = false;
    }
  }

  Future<void> getMyTournaments(String ownerId) async {
    try {
      isLoading = true;

      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.tournaments)
          .where('ownerId', isEqualTo: ownerId)
          .get();

      final tournaments = Tournament.getListFromFirebase(result.docs);

      _myTournaments = tournaments;
    } catch (err) {
      print("getMyTournaments err: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }
}
