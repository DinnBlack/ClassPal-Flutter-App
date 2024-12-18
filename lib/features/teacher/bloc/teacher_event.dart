part of 'teacher_bloc.dart';

@immutable
sealed class TeacherEvent {}

class TeacherInviteStarted extends TeacherEvent {}
