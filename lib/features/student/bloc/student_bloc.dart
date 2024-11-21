import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';
import 'package:flutter_class_pal/features/student/model/student_model.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/id_generator.dart';
import '../data/student_firebase.dart';

part 'student_event.dart';

part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentFirebase _studentFirebase;
  final StreamController<void> _fetchStreamController =
      StreamController<void>.broadcast();

  Stream<void> get fetchStream => _fetchStreamController.stream;

  StudentBloc(this._studentFirebase) : super(StudentInitial()) {
    on<StudentCreateStarted>(_onStudentCreateStarted);
    on<StudentFetchStarted>(_onStudentFetchStarted);
    on<StudentResetStarted>(_onStudentResetStarted);
  }

  Future<void> _onStudentResetStarted(
      StudentResetStarted event, Emitter<StudentState> emit) async {
    emit(StudentInitial());
  }

  Future<void> _onStudentCreateStarted(
      StudentCreateStarted event, Emitter<StudentState> emit) async {
    try {
      emit(StudentCreateInProgress());
      StudentModel newStudent = StudentModel(
        id: generateStudentId(),
        name: event.name,
        gender: event.gender,
        birthDate: event.birthDate,
        image: event.image ?? '',
        scores: List.empty(),
      );
      String studentId = await _studentFirebase.createStudent(
          newStudent, AppState.getClass()!.classId);

      if (studentId.isNotEmpty) {
        emit(StudentCreateSuccess());
        emit(StudentInitial());
        _fetchStreamController.add(null);
      } else {
        throw Exception("Failed to create student");
      }
    } catch (e) {
      emit(StudentCreateFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onStudentFetchStarted(
      StudentFetchStarted event, Emitter<StudentState> emit) async {
    try {
      emit(StudentFetchInProgress());
      List<StudentModel> students =
          await _studentFirebase.fetchStudents(AppState.getClass()!.classId);

      if (students.isNotEmpty) {
        emit(StudentFetchSuccess(students: students));
      } else {
        emit(StudentFetchFailure(error: "No students found"));
      }
    } catch (e) {
      emit(StudentFetchFailure(error: e.toString()));
    }
  }
}
