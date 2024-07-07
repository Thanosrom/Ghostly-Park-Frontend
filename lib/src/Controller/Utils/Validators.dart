//Check for valud Email,Username,Password and Car Model
bool isValidEmail(String email) {
  //final RegExp emailPattern =
  //RegExp(r'^[a-zA-Z0-9.!#$%&\*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,5}$');
  //return emailPattern.hasMatch(email);
  return true;
}

bool isValidUsername(String username) {
  final RegExp usernamePattern = RegExp(r'^[A-Za-z][A-Za-z0-9]{2,25}$');
  return usernamePattern.hasMatch(username);
}

bool isValidPassword(String password) {
  final RegExp passwordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?!.*[\\/#$<>%;&|(){}"`[\]]).{8,25}$');
  return passwordPattern.hasMatch(password);
}

bool isValidCarModel(String carModel) {
  final RegExp carModelPattern = RegExp(r'^[A-Za-z0-9\s-]{2,25}$');
  return carModelPattern.hasMatch(carModel);
}
