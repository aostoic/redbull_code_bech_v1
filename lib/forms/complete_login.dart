import 'package:flutter/material.dart';

class CompleteLoginForm with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String _name = '';
  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
