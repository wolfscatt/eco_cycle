import 'package:eco_cycle/src/domain/entities/user.dart';

abstract class BaseUserRepository {

  createUser(UserModel user);
  getUserDetails(String email);
  updateUser(UserModel user, String? id);
  deleteUser(UserModel user);
}
