part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RoleSelected extends AuthEvent {
  final String role;

  RoleSelected(this.role);
}