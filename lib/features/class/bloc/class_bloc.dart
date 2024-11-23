import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_class_pal/features/teacher/model/teacher_model.dart';
import 'package:meta/meta.dart';

import '../../../core/state/app_state.dart';
import '../data/class_firebase.dart';
import '../model/class_model.dart';

part 'class_event.dart';

part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassFirebase _classFirebase;
  final StreamController<void> _fetchStreamController =
      StreamController<void>.broadcast();

  Stream<void> get fetchStream => _fetchStreamController.stream;

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
        creatorId: currentUser.userId,
        isPersonalClass: false,
        students: [],
        teachers: [TeacherModel(uid: currentUser.userId, role: 'Giáo viên')],
        groups: [],
      );

      String classId = await _classFirebase.createClass(newClass);
      if (classId.isNotEmpty) {
        emit(ClassCreateSuccess());
        emit(ClassInitial());
        _fetchStreamController.add(null);
      } else {
        emit(ClassCreateFailure());
        emit(ClassInitial());
        add(ClassFetchStarted());
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
      List<ClassModel> classes = await _classFirebase.fetchClasses();
      print(classes);
      emit(ClassFetchSuccess(classes));
    } catch (e) {
      print("Error fetching classes: $e");
      emit(ClassFetchFailure());
    }
  }
}
