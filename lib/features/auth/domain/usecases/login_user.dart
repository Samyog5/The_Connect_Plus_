import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call(String email, String password) {
    return repository.loginUser(email, password);
  }
}
