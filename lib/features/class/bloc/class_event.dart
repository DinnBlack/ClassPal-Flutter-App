part of 'class_bloc.dart';

@immutable
sealed class ClassEvent {}

class ClassCreateStarted extends ClassEvent {}

class ClassFetchStarted extends ClassEvent {}
