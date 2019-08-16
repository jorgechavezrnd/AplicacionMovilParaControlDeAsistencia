import 'package:aplicacion_taller/domain/entities/subject.dart';

class UCBShowSubjectsViewModel {
  List<Subject> _subjectList;

  UCBShowSubjectsViewModel(this._subjectList);

  List<Subject> get subjectList => _subjectList;

  set subjectList(List<Subject> subjectList) => this._subjectList = subjectList;
}