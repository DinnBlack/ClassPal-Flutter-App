part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RoleSelectState extends AuthState {
  final String role;

  RoleSelectState(this.role);
}