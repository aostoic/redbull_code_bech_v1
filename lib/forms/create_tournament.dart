import 'package:flutter/material.dart';

class CreateTournamentForm with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String _title = '';
  String get title => _title;

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String _gameId = '';
  String get gameId => _gameId;

  set gameId(String value) {
    _gameId = value;
    notifyListeners();
  }

  String _description = '';
  String get description => _description;

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  int _playersQuantity = 0;
  int get playersQuantity => _playersQuantity;

  set playersQuantity(int value) {
    _playersQuantity = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
