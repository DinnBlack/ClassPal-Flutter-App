part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

// Student Create
class StudentCreateInProgress extends StudentState {}

class StudentCreateSuccess extends StudentState {}

class StudentCreateFailure extends StudentState {
  final String errorMessage;

  StudentCreateFailure({required this.errorMessage});
}

// Student Fetch
class StudentFetchInProgress extends StudentState {}

class StudentFetchSuccess extends StudentState {
  final List<StudentModel> students;

  StudentFetchSuccess({required this.students});
}

class StudentFetchFailure extends StudentState {
  final String error;

  StudentFetchFailure({required this.error});
}
