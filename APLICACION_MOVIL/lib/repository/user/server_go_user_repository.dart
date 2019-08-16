import 'dart:async';
import 'dart:convert';

import 'package:aplicacion_taller/domain/entities/user.dart';
import 'package:aplicacion_taller/domain/entityGateways/user_repository.dart';
import 'package:aplicacion_taller/utils/constants_and_functions.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class ServerGoUserRepository implements UserRepository {
  SocketIO _socketIO;
  Completer _completer;
  String _username;
  User _user;

  @override
  Future<User> findUser(String username) async {
    _username = username;
    _completer = Completer();

    _socketIO = SocketIOManager()
        .createSocketIO(SERVER_GO_URL, SERVER_NAMESPACE, query: SERVER_QUERY);
    _socketIO.init();
    _socketIO.connect();

    _socketIO.subscribe('server_connected', _onServerConnected);
    _socketIO.subscribe('get_user_response', _onGetUserResponse);

    _user = await _completer.future;

    if (_user.isEmpty()) {
      return null;
    }

    return _user;
  }

  void _onServerConnected(dynamic response) {
    String request = """
    {
      "username": "$_username"
    }
    """;

    _socketIO.sendMessage('get_user_request', request);
  }

  void _onGetUserResponse(dynamic response) {
    dynamic responseFix = getJsonString(response);
    var dataJson = jsonDecode(responseFix);
    User user = User.map(dataJson);

    _completer.complete(user);

    _socketIO.destroy();
  }
}
