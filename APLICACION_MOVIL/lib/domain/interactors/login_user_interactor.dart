import 'package:aplicacion_taller/domain/boundary/input/login_user_use_case.dart';
import 'package:aplicacion_taller/domain/dto/request/login_user_request.dart';
import 'package:aplicacion_taller/domain/dto/response/login_user_response.dart';
import 'package:aplicacion_taller/domain/entities/authentication.dart';
import 'package:aplicacion_taller/domain/entities/user.dart';
import 'package:aplicacion_taller/domain/entityGateways/user_repository.dart';
import 'package:aplicacion_taller/domain/boundary/output/login_user_presenter.dart';

class LoginUserInteractor implements LoginUserUseCase {
  UserRepository _userRepository;
  LoginUserPresenter _output;

  LoginUserInteractor(
      UserRepository userRepository, LoginUserPresenter output) {
    this._userRepository = userRepository;
    this._output = output;
  }

  @override
  Future<void> loginUser(LoginUserRequest request) async {
    String username = request.username;
    String password = request.password;

    User user = await _userRepository.findUser(username);

    if (user == null) {
      _output.displayLoginFailedUserNotExist();
    } else if (user.isPasswordCorrect(password)) {
      Authentication authentication = Authentication();

      authentication.id = user.id;
      authentication.username = user.username;
      authentication.name = user.name;

      LoginUserResponse response = LoginUserResponse(user.username);
      _output.displayLoginSuccess(response);
    } else {
      _output.displayLoginFailedIncorrectPassword();
    }
  }
}
