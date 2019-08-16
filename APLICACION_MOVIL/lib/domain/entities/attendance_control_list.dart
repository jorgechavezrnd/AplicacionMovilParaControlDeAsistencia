import 'package:aplicacion_taller/domain/entities/student.dart';

class AttendanceControlList {
  List<Student> _studentsPresentList;
  List<Student> _studentsMissingList;
  String _numberOfDoubtfulStudents;
  String _pictureWithFacesDetectedAndNamesBase64;

  AttendanceControlList(this._studentsPresentList, this._studentsMissingList, this._numberOfDoubtfulStudents, this._pictureWithFacesDetectedAndNamesBase64);

  List<Student> get studentsPresentList => _studentsPresentList;
  List<Student> get studentsMissingList => _studentsMissingList;
  String get numberOfDoubtfulStudents => _numberOfDoubtfulStudents;
  String get pictureWithFacesDetectedAndNamesBase64 => _pictureWithFacesDetectedAndNamesBase64;
}