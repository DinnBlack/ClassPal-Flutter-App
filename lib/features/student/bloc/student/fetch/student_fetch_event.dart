part of 'student_fetch_bloc.dart';

@immutable
sealed class StudentFetchEvent {}

class StudentFetchStarted extends StudentFetchEvent {}

class StudentFetchWithoutGroupStarted extends StudentFetchEvent {}
