mixin InputValidationMixin {
  bool isNameValid(String name) => name.isNotEmpty;
  bool isPasswordValid(String password) => password.length >= 6;
  bool isMobileValid(String mobileNo) {
    RegExp regex = RegExp(r"^[0-9]");
    return regex.hasMatch(mobileNo);
  }

  bool isPinValid(String pin) {
    RegExp regex = RegExp(r"^[0-9]");
    return regex.hasMatch(pin);
  }

  bool isCountryCodeValid(String code) => code.isNotEmpty;

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }
}
