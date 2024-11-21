part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

class StudentResetStarted extends StudentEvent {}

class StudentCreateStarted extends StudentEvent {
  final String name;
  final String gender;
  final String birthDate;
  final String? image;

  StudentCreateStarted({
    required this.name,
    required this.gender,
    required this.birthDate,
    this.image
  });
}

class StudentFetchStarted extends StudentEvent {}