import '../../domain/usecases/login_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc {
  final LoginUser loginUser;

  AuthBloc({required this.loginUser});

  Future<AuthState> handleLogin(LoginEvent event) async {
    try {
      final user = await loginUser(event.email, event.password);
      return AuthSuccessState(user: user);
    } catch (e) {
      return AuthErrorState(message: e.toString());
    }
  }

  Future<AuthState> handleLogout(LogoutEvent event) async {
    try {
      return AuthLoggedOutState();
    } catch (e) {
      return AuthErrorState(message: e.toString());
    }
  }

  Future<AuthState> handleCheckAuthStatus(CheckAuthStatusEvent event) async {
    // TODO: Implement check auth status logic
    return AuthInitialState();
  }
}
