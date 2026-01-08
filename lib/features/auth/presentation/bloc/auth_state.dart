import '../../domain/entities/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final User user;

  AuthSuccessState({required this.user});
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}

class AuthLoggedOutState extends AuthState {}
