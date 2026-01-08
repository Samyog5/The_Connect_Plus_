import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> loginUser(String email, String password) async {
    // TODO: Implement actual API call
    // For now, return a mock response
    await Future.delayed(Duration(seconds: 2));
    return UserModel(
      id: '1',
      email: email,
      name: 'User Name',
      role: 'student',
      token: 'mock_token_123',
    );
  }

  @override
  Future<void> logout() async {
    // TODO: Implement logout API call
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // TODO: Implement get current user API call
    return null;
  }
}
