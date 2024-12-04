import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/state/app_state.dart';
import '../../../../../core/utils/id_generator.dart';
import '../../../data/student_firebase.dart';
import '../../../model/student_model.dart';
import '../fetch/student_fetch_bloc.dart';

part 'student_create_event.dart';

part 'student_create_state.dart';

class StudentCreateBloc extends Bloc<StudentCreateEvent, StudentCreateState> {
  final StudentFirebase _studentFirebase;

  final StudentFetchBloc studentFetchBloc;

  StudentCreateBloc(this._studentFirebase, this.studentFetchBloc)
      : super(StudentCreateInitial()) {
    on<StudentCreateStarted>(_onStudentCreateStarted);
  }

  Future<void> _onStudentCreateStarted(
      StudentCreateStarted event, Emitter<StudentCreateState> emit) async {
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
        studentFetchBloc.add(StudentFetchStarted());

        emit(StudentCreateSuccess());
      } else {
        throw Exception("Failed to create student");
      }
    } catch (e) {
      emit(StudentCreateFailure(error: e.toString()));
    }
  }
}
