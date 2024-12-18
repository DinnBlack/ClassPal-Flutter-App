part of 'class_bloc.dart';

@immutable
sealed class ClassState {}

final class ClassInitial extends ClassState {}

/// States for class creation process
final class ClassCreateInProgress extends ClassState {}

final class ClassCreateSuccess extends ClassState {}

final class ClassCreateFailure extends ClassState {
  final String errorMessage;

  ClassCreateFailure(this.errorMessage);
}

/// States for class fetching process
final class ClassFetchInProgress extends ClassState {}

final class ClassFetchSuccess extends ClassState {
  final List<ClassModel> classes;

  ClassFetchSuccess(this.classes);
}

final class ClassFetchFailure extends ClassState {
  final String errorMessage;

  ClassFetchFailure(this.errorMessage);
}

/// States for inviting teacher process
final class ClassInviteTeacherInProgress extends ClassState {}

final class ClassInviteTeacherSuccess extends ClassState {}

final class ClassInviteTeacherFailure extends ClassState {
  final String errorMessage;

  ClassInviteTeacherFailure(this.errorMessage);
}

/// States for joining class process
final class ClassJoinInProgress extends ClassState {}

final class ClassJoinSuccess extends ClassState {}

final class ClassJoinFailure extends ClassState {
  final String errorMessage;

  ClassJoinFailure(this.errorMessage);
}