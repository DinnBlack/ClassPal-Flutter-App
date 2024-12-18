import 'package:bloc/bloc.dart';
import 'package:flutter_class_pal/features/auth/data/auth_firebase.dart';
import 'package:meta/meta.dart';
import '../../../core/state/app_state.dart';
import '../../user/model/user_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFirebase _authFirebase;

  AuthBloc(this._authFirebase) : super(AuthInitial()) {
    on<AuthSelectRoleStarted>(_onAuthSelectRoleStarted);
    on<AuthLoginStarted>(_onAuthLoginStarted);
    on<AuthRegisterStarted>(_onAuthRegisterStarted);
    on<AuthLogoutStarted>(_onAuthLogoutStarted);
  }

  // bloc chọn role
  Future<void> _onAuthSelectRoleStarted(
      AuthSelectRoleStarted event, Emitter<AuthState> emit) async {
    AppState.setRole(event.role);
    emit(RoleSelectState(event.role));
  }

  // bloc đăng nhập
  Future<void> _onAuthLoginStarted(
      AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());
    UserModel? user =
        await _authFirebase.loginUser(event.email, event.password);
    AppState.setUser(user!);
    emit(AuthLoginSuccess(user));
    }

  // bloc đăng ký
  Future<void> _onAuthRegisterStarted(
      AuthRegisterStarted event, Emitter<AuthState> emit) async {
    emit(AuthRegisterInProgress());
    try {
      UserModel? user = await _authFirebase.registerUser(
        UserModel(
          userId: '',
          name: event.name,
          email: event.email,
          password: event.password,
          gender: event.gender,
          schoolsIds: [],
          classesIds: [],
          childrenIds: [],
        ),
        event.password,
      );
      if (user != null) {
        emit(AuthRegisterSuccess(user));
        print(user);
      } else {
        emit(AuthRegisterFailure("User creation failed"));
      }
    } catch (e) {
      emit(AuthRegisterFailure("Error: $e"));
    }
  }

  // bloc đăng xuất
  Future<void> _onAuthLogoutStarted(
      AuthLogoutStarted event, Emitter<AuthState> emit) async {
    emit(AuthLogoutInProgress());
    try {
      // await _authFirebase.logout();
      emit(AuthLogoutSuccess());
    } catch (e) {
      emit(AuthLogoutFailure("Login failed"));
    }
  }
}
