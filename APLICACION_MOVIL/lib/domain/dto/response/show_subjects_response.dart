import 'package:aplicacion_taller/domain/entities/subject.dart';

class ShowSubjectsResponse {
  List<Subject> _subjectList;

  ShowSubjectsResponse(this._subjectList);

  List<Subject> get subjectList => _subjectList;
}