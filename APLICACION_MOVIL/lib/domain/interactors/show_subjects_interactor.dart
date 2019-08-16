import 'package:aplicacion_taller/domain/boundary/input/show_subjects_use_case.dart';
import 'package:aplicacion_taller/domain/boundary/output/show_subjects_presenter.dart';
import 'package:aplicacion_taller/domain/dto/request/show_subjects_request.dart';
import 'package:aplicacion_taller/domain/dto/response/show_subjects_response.dart';
import 'package:aplicacion_taller/domain/entities/subject.dart';
import 'package:aplicacion_taller/domain/entityGateways/show_subjects_repository.dart';

class ShowSubjectsInteractor implements ShowSubjectsUseCase {
  SubjectRepository _subjectRepository;
  ShowSubjectsPresenter _output;

  ShowSubjectsInteractor(this._subjectRepository, this._output);

  @override
  Future<void> showSubjects(ShowSubjectsRequest request) async {
    String userID = request.userID;

    List<Subject> subjectList = await _subjectRepository.findSubjects(userID);
    ShowSubjectsResponse response = ShowSubjectsResponse(subjectList);

    _output.displaySubjects(response);
  }
}