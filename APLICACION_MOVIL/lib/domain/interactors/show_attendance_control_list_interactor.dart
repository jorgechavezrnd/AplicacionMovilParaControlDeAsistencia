import 'package:aplicacion_taller/domain/boundary/input/show_attendance_control_list_use_case.dart';
import 'package:aplicacion_taller/domain/boundary/output/show_attendance_control_list_presenter.dart';
import 'package:aplicacion_taller/domain/dto/request/show_attendance_control_list_request.dart';
import 'package:aplicacion_taller/domain/dto/response/show_attendance_control_list_response.dart';
import 'package:aplicacion_taller/domain/entities/attendance_control_list.dart';
import 'package:aplicacion_taller/domain/entityGateways/student_repository.dart';

class ShowAttendanceControlListInteractor
    implements ShowAttendanceControlListUseCase {
  StudentRepository _studentRepository;
  ShowAttendanceControlListPresenter _output;

  ShowAttendanceControlListInteractor(this._studentRepository, this._output);

  @override
  Future<void> showAttendanceControlList(ShowAttendanceControlListRequest request) async {
    String subjectID = request.subjectID;
    String parallelID = request.parallelID;
    String imageBase64 = request.imageBase64;

    AttendanceControlList attendanceControlList = await _studentRepository
        .findStudents(imageBase64, subjectID, parallelID);

    ShowAttendanceControlListResponse response = ShowAttendanceControlListResponse(
            attendanceControlList.studentsPresentList,
            attendanceControlList.studentsMissingList,
            attendanceControlList.numberOfDoubtfulStudents,
            attendanceControlList.pictureWithFacesDetectedAndNamesBase64
        );

    _output.displayAttendanceControlList(response);
  }
}
