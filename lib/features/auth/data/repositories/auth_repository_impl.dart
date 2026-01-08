import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> loginUser(String email, String password) async {
    final userModel = await remoteDataSource.loginUser(email, password);
    return User(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
      role: userModel.role,
      token: userModel.token,
    );
  }

  @override
  Future<void> logout() async {
    return remoteDataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await remoteDataSource.getCurrentUser();
    if (userModel == null) return null;
    return User(
      id: userModel.id,
      email: userModel.email,
      name: userModel.name,
      role: userModel.role,
      token: userModel.token,
    );
  }
}
