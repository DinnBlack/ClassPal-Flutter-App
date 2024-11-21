part of 'class_bloc.dart';

@immutable
sealed class ClassEvent {}

class ClassResetStarted extends ClassEvent {}

class ClassCreateStarted extends ClassEvent {
  final String className;

  ClassCreateStarted({required this.className});
}

class ClassFetchStarted extends ClassEvent {}
