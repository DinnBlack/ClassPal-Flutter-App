part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// Event chọn role
class AuthSelectRoleStarted extends AuthEvent {
  final String role;

  AuthSelectRoleStarted(this.role);
}

// Event đăng nhập
class AuthLoginStarted extends AuthEvent {
  final String email;
  final String password;

  AuthLoginStarted(
      {required this.email, required this.password});
}

// Event đăng ký
class AuthRegisterStarted extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  final String gender;

  AuthRegisterStarted({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
  });
}
