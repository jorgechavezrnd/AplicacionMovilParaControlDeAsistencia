import 'package:aplicacion_taller/domain/entities/attendance_control_list.dart';
import 'package:aplicacion_taller/domain/entityGateways/student_repository.dart';
import 'package:aplicacion_taller/utils/constants_and_functions.dart';
import 'package:aplicacion_taller/domain/entities/student.dart';
import 'package:aplicacion_taller/presentation/ucb/view/ucb_show_attendance_control_list_view.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

class ServerGoStudentRepository implements StudentRepository {
  SocketIO _socketIO;
  Completer _completer;
  String _imageBase64;
  String _subjectID;
  String _parallelID;
  AttendanceControlList _attendanceControlList;
  UCBShowAttendanceControlListView _ucbShowAttendanceControlListView;

  ServerGoStudentRepository(this._ucbShowAttendanceControlListView);

  @override
  Future<AttendanceControlList> findStudents(String imageBase64, String subjectID, String parallelID) async {
    _imageBase64 = imageBase64;
    _subjectID = subjectID;
    _parallelID = parallelID;
    _completer = Completer();

    _socketIO = SocketIOManager().createSocketIO(SERVER_GO_URL, SERVER_NAMESPACE, query: SERVER_QUERY);
    _socketIO.init();
    _socketIO.connect();

    _socketIO.subscribe('server_connected', _onServerConnected);
    _socketIO.subscribe('get_attendance_control_list_response', _onGetAttendanceControlListResponse);
    _socketIO.subscribe('faces_detected_response', _onFacesDetectedResponse);
    _socketIO.subscribe('progress_response', _onProgressResponse);

    _attendanceControlList = await _completer.future;

    return _attendanceControlList;
  }

  void _onServerConnected(dynamic response) {
    String request = """
    {
      "subject_id": "$_subjectID",
      "paralel_id": "$_parallelID",
      "image_base_64": "$_imageBase64"
    }
    """;

    _socketIO.sendMessage('get_attendance_control_list_request', request);
  }

  void _onGetAttendanceControlListResponse(dynamic response) {
    dynamic responseFix = getJsonString(response);
    var dataJson = jsonDecode(responseFix);
    List<Student> studentsPresentList = List<Student>();
    List<Student> studentsMissingList = List<Student>();
    String numberOfDoubtfulStudents = '';
    String pictureWithFacesDetectedAndNamesBase64 = '';

    List<dynamic> studentsPresentListJson = dataJson['students_present_list'];
    List<dynamic> studentsMissingListJson = dataJson['students_missing_list'];
    numberOfDoubtfulStudents = dataJson['number_of_doubtful_students'];
    pictureWithFacesDetectedAndNamesBase64 = dataJson['picture_with_faces_detected_and_names_base_64'];

    studentsPresentListJson.forEach((data) {
      studentsPresentList.add(Student.map(data));
    });

    studentsMissingListJson.forEach((data) {
      studentsMissingList.add(Student.map(data));
    });

    AttendanceControlList attendanceControlList = AttendanceControlList(studentsPresentList, studentsMissingList, numberOfDoubtfulStudents, pictureWithFacesDetectedAndNamesBase64);

    _completer.complete(attendanceControlList);

    _socketIO.destroy();
  }

  void _onFacesDetectedResponse(dynamic response) {
    dynamic responseFix = getJsonString(response);
    var dataJson = jsonDecode(responseFix);
    String numberOfFaces = dataJson['number_of_faces'];
    String pictureWithFacesDetectedBase64 = dataJson['picture_with_faces_detected_base_64'];

    Widget body = SingleChildScrollView(
      child: Center(
        child: ListBody(
          children: <Widget>[
            Center(
              child: Text('ROSTROS DETECTADOS'),
            ),
            Center(
              child: Image.memory(base64Decode(pictureWithFacesDetectedBase64)),
            ),
            Center(
              child: Text('CANTIDAD DE ROSTROS DETECTADOS: $numberOfFaces'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );

    _ucbShowAttendanceControlListView.ucbShowAttendanceControlListViewState.changeStateAndBody(false, body);
  }

  void _onProgressResponse(dynamic response) {
    dynamic responseFix = getJsonString(response);
    var dataJson = jsonDecode(responseFix);
    String percentageString = dataJson['percentage'];

    print('ON PROGRESS RESPONSE: $dataJson');


    _ucbShowAttendanceControlListView.ucbShowAttendanceControlListViewState.changePercentage(percentageString);
  }
}