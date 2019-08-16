import 'package:aplicacion_taller/domain/entities/subject.dart';

abstract class SubjectRepository {
  Future<List<Subject>> findSubjects(String userID);
}