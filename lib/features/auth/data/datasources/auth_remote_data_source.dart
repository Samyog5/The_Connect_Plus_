import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}
