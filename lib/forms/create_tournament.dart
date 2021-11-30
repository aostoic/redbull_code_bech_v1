import 'package:flutter/material.dart';

class CreateTournamentForm with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String _urlImage = '';
  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
    notifyListeners();
  }

  String _title = '';
  String get title => _title;

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String _game = '';
  String get game => _game;

  set game(String value) {
    _game = value;
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
