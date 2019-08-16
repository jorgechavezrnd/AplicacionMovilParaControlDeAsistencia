import 'package:aplicacion_taller/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> findUser(String username);
}