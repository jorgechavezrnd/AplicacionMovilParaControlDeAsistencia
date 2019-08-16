class UCBLoginUserViewModel {
  String _message;

  UCBLoginUserViewModel(this._message);

  String get message => _message;

  set message(String message) => this._message = message;
}