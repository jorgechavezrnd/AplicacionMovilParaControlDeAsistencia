class Subject {
  String _id;
  String _parallel;
  String _name;

  Subject(this._id, this._parallel, this._name);

  String get id => _id;
  String get name => _name;
  String get parallel => _parallel;

  Subject.map(dynamic obj) {
    this._id = obj['id'];
    this._parallel = obj['parallel'];
    this._name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['parallel'] = _parallel;
    map['name'] = _name;
    return map;
  }
}