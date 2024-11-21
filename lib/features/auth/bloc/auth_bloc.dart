import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/state/app_state.dart';
import '../../user/model/user_model.dart';
import '../data/auth_firebase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFirebase _authFirebase;
  String? _currentRole;
  UserModel? _currentUser;

  AuthBloc(this._authFirebase) : super(AuthInitial()) {
    on<AuthSelectRoleStarted>(_onAuthSelectRoleStarted);
    on<AuthLoginStarted>(_onAuthLoginStarted);
    on<AuthRegisterStarted>(_onAuthRegisterStarted);
  }

  // bloc chọn role
  Future<void> _onAuthSelectRoleStarted(
      AuthSelectRoleStarted event, Emitter<AuthState> emit) async {
    _currentRole = event.role;
    AppState.setRole(event.role);
    emit(RoleSelectState(event.role));
  }

  // bloc đăng nhập
  Future<void> _onAuthLoginStarted(
      AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());
    UserModel? user =
        await _authFirebase.loginUser(event.email, event.password);
    print(event.email);
    print(event.password);
    print(user);
    if (user != null) {
      _currentUser = user;
      AppState.setUser(user);
      emit(AuthLoginSuccess(user));
      print('Bloc Thành Công');
    } else {
      emit(AuthLoginFailure("Login failed"));
      print('Bloc Thất Bại');
    }
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
}
