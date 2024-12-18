part of 'class_bloc.dart';

@immutable
sealed class ClassEvent {}

class ClassResetStarted extends ClassEvent {}

class ClassCreateStarted extends ClassEvent {
  final String className;

  ClassCreateStarted({required this.className});
}

class ClassFetchStarted extends ClassEvent {}

class ClassInviteTeacherStarted extends ClassEvent {
  final String teacherEmail;

  ClassInviteTeacherStarted({required this.teacherEmail});
}

class ClassJoinStarted extends ClassEvent {
  final String classId;

  ClassJoinStarted({required this.classId});
}

