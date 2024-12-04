part of 'student_create_bloc.dart';

@immutable
sealed class StudentCreateEvent {}

class StudentCreateStarted extends StudentCreateEvent {
  final String name;
  final String gender;
  final String birthDate;
  final String? image;

  StudentCreateStarted(
      {required this.name,
      required this.gender,
      required this.birthDate,
      this.image});
}
