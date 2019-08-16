class User {
  String _id;
  String _username;
  String _password;
  String _name;

  User(this._id, this._username, this._password, this._name);

  String get id => _id;
  String get username => _username;
  String get password => _password;
  String get name => _name;

  set id(String id) => this._id = id;
  set username(String username) => this._username = username;
  set password(String password) => this._password = password;
  set name(String name) => this._name = name;

  bool isPasswordCorrect(String password) {
    return this._password == password;
  }

  bool isEmpty() {
    return this._id == "";
  }

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['username'] = _username;
    map['password'] = _password;
    map['name'] = _name;
    return map;
  }
}