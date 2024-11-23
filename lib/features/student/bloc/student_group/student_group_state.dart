part of 'student_group_bloc.dart';

@immutable
sealed class StudentGroupState {}

final class StudentGroupInitial extends StudentGroupState {}

// Student Group Create
class StudentGroupCreateInProgress extends StudentGroupState {}

class StudentGroupCreateSuccess extends StudentGroupState {}

class StudentGroupCreateFailure extends StudentGroupState {
  final String error;

  StudentGroupCreateFailure({required this.error});
}

// Student Group Fetch
class StudentGroupFetchInProgress extends StudentGroupState {}

class StudentGroupFetchSuccess extends StudentGroupState {
  final List<StudentGroupModel> studentGroups;

  StudentGroupFetchSuccess({required this.studentGroups});
}

class StudentGroupFetchFailure extends StudentGroupState {
  final String error;

  StudentGroupFetchFailure({required this.error});
}

// Student Group Update
class StudentGroupUpdateInProgress extends StudentGroupState {}

class StudentGroupUpdateSuccess extends StudentGroupState {}

class StudentGroupUpdateFailure extends StudentGroupState {
  final String error;

  StudentGroupUpdateFailure({required this.error});
}