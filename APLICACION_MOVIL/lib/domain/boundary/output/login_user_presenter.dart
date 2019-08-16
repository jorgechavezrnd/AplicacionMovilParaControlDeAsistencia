import 'package:aplicacion_taller/domain/dto/response/login_user_response.dart';

abstract class LoginUserPresenter {
  void displayLoginSuccess(LoginUserResponse response);
  void displayLoginFailedIncorrectPassword();
  void displayLoginFailedUserNotExist();
}