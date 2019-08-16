import 'package:aplicacion_taller/domain/entities/subject.dart';
import 'package:aplicacion_taller/domain/entities/student.dart';

class Authentication {
  String _id;
  String _username;
  String _name;
  Subject _subject;
  List<Student> _studentsPresentList;
  List<Student> _studentsMissingList;

  static Authentication _instance = Authentication.internal();
  Authentication.internal();
  factory Authentication() => _instance;

  String get id => _id;
  String get username => _username;
  String get name => _name;
  Subject get subject => _subject;
  List<Student> get studentsPresentList => _studentsPresentList;
  List<Student> get studentsMissingList => _studentsMissingList;

  set id(String id) => this._id = id;
  set username(String username) => this._username = username;
  set name(String name) => this._name = name;
  set subject(Subject subject) => this._subject = subject;
  set studentsPresentList(List<Student> studentsPresentList) => this._studentsPresentList = studentsPresentList;
  set studentsMissingList(List<Student> studentsMissingList) => this._studentsMissingList = studentsMissingList;

  bool isEmpty() {
    return this._id == null;
  }
}
