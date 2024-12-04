part of 'student_create_bloc.dart';

@immutable
sealed class StudentCreateState {}

final class StudentCreateInitial extends StudentCreateState {}

// Student Create
class StudentCreateInProgress extends StudentCreateState {}

class StudentCreateSuccess extends StudentCreateState {}

class StudentCreateFailure extends StudentCreateState {
  final String error;

  StudentCreateFailure({required this.error});
}