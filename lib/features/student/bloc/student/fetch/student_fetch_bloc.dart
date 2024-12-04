import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/state/app_state.dart';
import '../../../data/student_firebase.dart';
import '../../../model/student_model.dart';

part 'student_fetch_event.dart';

part 'student_fetch_state.dart';

class StudentFetchBloc extends Bloc<StudentFetchEvent, StudentFetchState> {
  final StudentFirebase _studentFirebase;

  StudentFetchBloc(this._studentFirebase) : super(StudentFetchInitial()) {
    on<StudentFetchStarted>(_onStudentFetchStarted);
    on<StudentFetchWithoutGroupStarted>(_onStudentFetchWithoutGroupStarted);
  }

  Future<void> _onStudentFetchStarted(
      StudentFetchStarted event, Emitter<StudentFetchState> emit) async {
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

  Future<void> _onStudentFetchWithoutGroupStarted(
      StudentFetchWithoutGroupStarted event,
      Emitter<StudentFetchState> emit) async {
    try {
      // Fetch students without a group
      List<StudentModel> students =
          await _studentFirebase.fetchStudentsWithoutGroup();

      if (students.isNotEmpty) {
        emit(StudentFetchSuccess(students: students));
      } else {
        emit(StudentFetchFailure(error: "No students found without a group"));
      }
    } catch (e) {
      emit(StudentFetchFailure(error: e.toString()));
    }
  }


}
