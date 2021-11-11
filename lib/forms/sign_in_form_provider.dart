import 'package:flutter/material.dart';

class SignInFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String _email = "";
  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = "";
  String get password => _password;

  set password(String value) {
    _password = value;
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
