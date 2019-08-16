import 'package:aplicacion_taller/domain/dto/request/show_attendance_control_list_request.dart';

abstract class ShowAttendanceControlListUseCase {
  Future<void> showAttendanceControlList(ShowAttendanceControlListRequest request);
}