part of 'class_bloc.dart';

@immutable
sealed class ClassState {}

final class ClassInitial extends ClassState {}

// Class Create State
class ClassCreateInProgress extends ClassState {}

class ClassCreateSuccess extends ClassState {}

class ClassCreateFailure extends ClassState {}

// Class Fetch State
class ClassFetchInProgress extends ClassState {}

class ClassFetchSuccess extends ClassState {
  final List<ClassModel> classes;

  ClassFetchSuccess(this.classes);
}

class ClassFetchFailure extends ClassState {}
