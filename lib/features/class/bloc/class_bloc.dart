import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/state/app_state.dart';
import '../data/class_firebase.dart';
import '../model/class_model.dart';

part 'class_event.dart';

part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassFirebase _classFirebase;

  ClassBloc(this._classFirebase) : super(ClassInitial()) {
    on<ClassCreateStarted>(_onClassCreateStarted);
    on<ClassFetchStarted>(_onClassFetchStarted);
    on<ClassResetStarted>(_onClassResetStarted);
  }

  Future<void> _onClassResetStarted(
      ClassResetStarted event, Emitter<ClassState> emit) async {
    emit(ClassInitial());
  }

  Future<void> _onClassCreateStarted(
      ClassCreateStarted event, Emitter<ClassState> emit) async {
    emit(ClassCreateInProgress());
    try {
      var currentUser = AppState.getUser();
      if (currentUser == null) {
        emit(ClassCreateFailure());
        return;
      }

      ClassModel newClass = ClassModel(
        classId: '',
        className: event.className,
        schoolId: '',
        teacherIds: [currentUser.userId],
        studentIds: [],
        creatorId: currentUser.userId,
        isPersonalClass: false,
      );

      String classId = await _classFirebase.createClass(newClass);
      if (classId.isNotEmpty) {
        emit(ClassCreateSuccess());
        emit(ClassInitial());
      } else {
        emit(ClassCreateFailure());
        emit(ClassInitial());
      }
    } catch (e) {
      print("Error creating class: $e");
      emit(ClassCreateFailure());
    }
  }

  Future<void> _onClassFetchStarted(
      ClassFetchStarted event, Emitter<ClassState> emit) async {
    emit(ClassFetchInProgress());
    try {
      var currentUser = AppState.getUser();
      print(currentUser);
      if (currentUser == null) {
        emit(ClassFetchFailure());
        return;
      }

      List<ClassModel> classes = await _classFirebase.fetchClasses();
      print(classes);

      emit(ClassFetchSuccess(classes));

    } catch (e) {
      print("Error fetching classes: $e");
      emit(ClassFetchFailure());
    }
  }
}
