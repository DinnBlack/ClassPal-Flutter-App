part of 'student_fetch_bloc.dart';

@immutable
sealed class StudentFetchState {}

final class StudentFetchInitial extends StudentFetchState {}

// Student Fetch
class StudentFetchInProgress extends StudentFetchState {}

class StudentFetchSuccess extends StudentFetchState {
  final List<StudentModel> students;

  StudentFetchSuccess({required this.students});
}

class StudentFetchFailure extends StudentFetchState {
  final String error;

  StudentFetchFailure({required this.error});
}
