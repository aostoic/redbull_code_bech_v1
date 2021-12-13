import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:redbull_code_bech_v1/helpers/helpers.dart';
import 'package:redbull_code_bech_v1/models/models.dart';
import 'package:uuid/uuid.dart';

class TournamentService extends ChangeNotifier {
  final _uuid = const Uuid();
  final _collection = FirebaseFirestore.instance.collection(
    AppFirebaseCollections.tournaments,
  );

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

  List<Tournament> _tournamentsByGame = [];
  List<Tournament> get tournamentsByGame => _tournamentsByGame;

  set tournamentsByGame(List<Tournament> values) {
    _tournamentsByGame = values;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Tournament> _filteredTournaments = [];
  List<Tournament> get filteredTournaments => _filteredTournaments;

  set filteredTournaments(List<Tournament> values) {
    _filteredTournaments = values;
    notifyListeners();
  }

  String _searchText = '';
  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void searchTournamentsByText(String value) {
    searchText = value;

    if (value.isEmpty) {
      filteredTournaments = [];
    } else {
      String finalValue = value.toLowerCase();

      RegExp regExp = RegExp(
        finalValue,
        caseSensitive: false,
        multiLine: false,
      );

      filteredTournaments = myTournaments
          .where((tournament) =>
              tournament.title.toLowerCase().contains(regExp) ||
              tournament.status.toLowerCase().contains(regExp))
          .toList();
    }
  }

  Future<void> getTournaments(String ownerId) async {
    try {
      isLoading = true;

      final result = await _collection.get();

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

      final result =
          await _collection.where('ownerId', isEqualTo: ownerId).get();

      myTournaments = Tournament.getListFromFirebase(result.docs);
    } catch (err) {
      print("getMyTournaments err: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }

  Future<void> getTournamentsByGame(String gameId) async {
    try {
      isLoading = true;

      final result = await _collection.where('gameId', isEqualTo: gameId).get();

      tournamentsByGame = Tournament.getListFromFirebase(result.docs);
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

      final newId = _uuid.v4();

      final Tournament newTournament = Tournament(
        id: newId,
        title: title,
        description: description,
        status: 'waiting',
        gameId: gameId,
        playersQuantity: playersQuantity,
        ownerId: ownerId,
        players: [],
        winnerIds: [],
      );

      await _collection.doc(newId).set(newTournament.toJson());

      return newTournament;
    } catch (err) {
      print("createTournament error: ${err.toString()}");
      return null;
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteTournament(
    String id,
  ) async {
    try {
      if (myTournaments.length == 1) {
        isLoading = true;
      }

      await _collection.doc(id).delete();

      myTournaments =
          myTournaments.where((tournament) => tournament.id != id).toList();
    } catch (err) {
      print("deletePatient error: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }

  Future<void> signUpTournament(
    User user,
    Tournament tournament,
  ) async {
    try {
      isLoading = true;

      final Player newPlayer = Player(
        id: user.uid,
        name: user.email!,
      );

      tournament.players.add(newPlayer);

      await _collection.doc(tournament.id).update({
        'players': tournament.players,
      });
    } catch (err) {
      print("signUpTournament error: ${err.toString()}");
    } finally {
      isLoading = false;
    }
  }
}
