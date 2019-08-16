class LoginUserRequest {
  String _username;
  String _password;

  LoginUserRequest(this._username, this._password);

  String get username => _username;
  String get password => _password;
}