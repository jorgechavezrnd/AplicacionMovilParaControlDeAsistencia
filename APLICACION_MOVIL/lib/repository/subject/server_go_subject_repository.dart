import 'dart:async';
import 'dart:convert';

import 'package:aplicacion_taller/domain/entities/subject.dart';
import 'package:aplicacion_taller/domain/entityGateways/show_subjects_repository.dart';
import 'package:aplicacion_taller/utils/constants_and_functions.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class ServerGoSubjectRepository implements SubjectRepository {
  SocketIO _socketIO;
  Completer _completer;
  String _userID;
  List<Subject> _subjects;

  @override
  Future<List<Subject>> findSubjects(String userID) async {
    _userID = userID;
    _completer = Completer();

    _socketIO = SocketIOManager()
        .createSocketIO(SERVER_GO_URL, SERVER_NAMESPACE, query: SERVER_QUERY);
    _socketIO.init();
    _socketIO.connect();

    _socketIO.subscribe('server_connected', _onServerConnected);
    _socketIO.subscribe('get_subjects_response', _onGetSubjectsResponse);

    _subjects = await _completer.future;

    return _subjects;
  }

  void _onServerConnected(dynamic response) {
    String request = """
    {
      "user_id": "$_userID"
    }
    """;

    _socketIO.sendMessage('get_subjects_request', request);
  }

  void _onGetSubjectsResponse(dynamic response) {
    dynamic responseFix = getJsonString(response);
    var dataJson = jsonDecode(responseFix);
    List<Subject> subjects = List<Subject>();

    List<dynamic> subjectsJson = dataJson['subjects'];

    subjectsJson.forEach((data) {
      subjects.add(Subject.map(data));
    });

    _completer.complete(subjects);

    _socketIO.destroy();
  }
}
