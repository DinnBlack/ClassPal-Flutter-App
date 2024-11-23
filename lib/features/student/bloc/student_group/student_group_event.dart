part of 'student_group_bloc.dart';

@immutable
sealed class StudentGroupEvent {}

class StudentGroupResetStarted  extends StudentGroupEvent {}

class StudentGroupCreateStarted extends StudentGroupEvent {
  final String groupName;
  final List<String> studentIds;

  StudentGroupCreateStarted({
    required this.groupName,
    required this.studentIds,
  });
}

class StudentGroupFetchStarted extends StudentGroupEvent {
}

class StudentGroupUpdateStarted extends StudentGroupEvent {
  final String groupId;
  final String newGroupName;
  final List<String> updatedStudentIds;

  StudentGroupUpdateStarted({
    required this.groupId,
    required this.newGroupName,
    required this.updatedStudentIds,
  });
}