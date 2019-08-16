import 'package:aplicacion_taller/domain/dto/request/login_user_request.dart';

abstract class LoginUserUseCase {
  Future<void> loginUser(LoginUserRequest request);
}