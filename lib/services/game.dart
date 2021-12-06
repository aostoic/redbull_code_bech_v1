import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';

class GameService extends ChangeNotifier {
  Game? _currentGame;
  Game? get currentGame => _currentGame;

  set currentGame(Game? value) {
    _currentGame = value;
    notifyListeners();
  }

  List<Game> _games = [];
  List<Game> get games => _games;

  set games(List<Game> values) {
    _games = values;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getGames() async {
    try {
      isLoading = true;

      final result = await FirebaseFirestore.instance
          .collection(AppFirebaseCollections.games)
          .get();

      games = Game.getListFromFirebase(result.docs);
    } catch (err) {
      print("getGames err: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }
}
