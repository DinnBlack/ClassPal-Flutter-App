part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Chọn role state
class RoleSelectState extends AuthState {
  final String role;

  RoleSelectState(this.role);
}

// Đăng nhập state
class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final UserModel user;

  AuthLoginSuccess(this.user);
}

class AuthLoginFailure extends AuthState {
  final String error;

  AuthLoginFailure(this.error);
}

// Đăng ký state
class AuthRegisterInProgress extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  final UserModel user;

  AuthRegisterSuccess(this.user);
}

class AuthRegisterFailure extends AuthState {
  final String error;

  AuthRegisterFailure(this.error);
}