class UCBLoginFormViewModel {
  String _usernamePlaceholder;
  String _passwordPlaceholder;
  String _loginButtonText;
  String _backgroundImageURL;
  String _logoImageURL;

  UCBLoginFormViewModel(this._usernamePlaceholder, this._passwordPlaceholder,
      this._loginButtonText, this._backgroundImageURL, this._logoImageURL);

  String get usernamePlaceholder => _usernamePlaceholder;
  String get passwordPlaceholder => _passwordPlaceholder;
  String get loginButtonText => _loginButtonText;
  String get backgroundImageURL => _backgroundImageURL;
  String get logoImageURL => _logoImageURL;

  set usernamePlaceholder(String usernamePlaceholder) =>
      this._usernamePlaceholder = usernamePlaceholder;
  set passwordPlaceholder(String passwordPlaceholder) =>
      this._passwordPlaceholder = passwordPlaceholder;
  set loginButtonText(String loginButtonText) =>
      this._loginButtonText = loginButtonText;
  set backgroundImageURL(String backgroundImageURL) =>
      this._backgroundImageURL = backgroundImageURL;
  set logoImageURL(String logoImageURL) => this._logoImageURL = logoImageURL;
}
