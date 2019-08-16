class Student {
  String _id;
  String _name;
  String _pictureURL;

  Student(this._id, this._name, this._pictureURL);

  String get id => _id;
  String get name => _name;
  String get pictureURL => _pictureURL;

  set id(String id) => this._id = id;
  set name(String name) => this._name = name;
  set pictureURL(String pictureURL) => this._pictureURL = pictureURL;

  Student.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._pictureURL = obj['picture_url'];
  }
}