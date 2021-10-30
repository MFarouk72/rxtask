import 'package:validators/validators.dart' as validator;

class Validations {
  static bool isMobileNumberNotValid(String mobileNumber) {
    return validator.isLength(mobileNumber, 9, 20);
  }

  static checkEmail(String email) {
    if (email.isNotEmpty)
      return !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return false;
  }

  static checkPassword(String password) {
    if (password.isNotEmpty)
      return !RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,}")
          .hasMatch(password);
    return false;
  }

  static isHasArabicChar(String value) {
    if (value.isNotEmpty)
      return !RegExp(r"^[a-zA-Z-0-9-.-_.@.\s\']*$").hasMatch(value);
    return false;
  }

  static bool isUserNameNotValid(String name) {
    return false;
  }

  /// Password strategy min 8 digits
  /// min 1 numeric
  /// min 1 lowercase character
  /// min 1 uppercase character
  /// min 1 special character
  static bool validatePassword(String password) => RegExp(
    r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])([a-zA-Z0-9@$!%*?&]{8,})$",
    multiLine: false,
  ).hasMatch(password);
}
