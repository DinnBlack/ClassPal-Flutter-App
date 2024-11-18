import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/user_firebase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserFirebase userFirebase;

  UserBloc(this.userFirebase) : super(UserInitial()) {
  }

}
