class AppValidators {
  static String? isValidEmail(String value) {
    if (value.isEmpty) {
      return null;
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      return regExp.hasMatch(value) ? null : "Invalid email";
    }
  }

  static String? isValidPassword(String value) {
    if (value.isNotEmpty && value.length < 6) return "Min 6 characters";
    return null;
  }

  static String? isValidName(String value) {
    if (value.isNotEmpty && value.length < 2) return "Min 2 characters";
    return null;
  }

  static String? isValidIdentificationDocument(String value) {
    if (value.isNotEmpty && value.length < 8) return "Min 8 characters";
    return null;
  }

  static String? isValidPhoneNumber(String value) {
    if (value.isNotEmpty && value.length < 11) return "Min 9 digits";
    return null;
  }

  static String? isValidBirthday(String value) {
    if (value.isNotEmpty && value.length < 10) return "Complete birthday";
    return null;
  }
}
