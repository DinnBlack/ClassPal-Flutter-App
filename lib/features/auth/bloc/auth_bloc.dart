import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/state/app_state.dart';


part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RoleSelected>(_onRoleSelected);
  }

  Future<void> _onRoleSelected(
      RoleSelected event, Emitter<AuthState> emit) async {
    AppState.setRole(event.role);
    emit(RoleSelectState(event.role));
  }
}
