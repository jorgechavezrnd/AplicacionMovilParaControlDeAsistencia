import 'package:aplicacion_taller/domain/dto/request/show_subjects_request.dart';

abstract class ShowSubjectsUseCase {
  Future<void> showSubjects(ShowSubjectsRequest request);
}