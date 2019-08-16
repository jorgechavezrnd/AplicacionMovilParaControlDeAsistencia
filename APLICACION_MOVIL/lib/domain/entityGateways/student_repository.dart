import 'package:aplicacion_taller/domain/entities/attendance_control_list.dart';

abstract class StudentRepository {
  Future<AttendanceControlList> findStudents(String imageBase64, String subjectID, String parallelID);
}