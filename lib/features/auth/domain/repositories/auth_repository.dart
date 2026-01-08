import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> loginUser(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
