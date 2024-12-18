part of 'subject_cubit.dart';

@immutable
sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}

//Create a new Subject
class SubjectCreateInProgress extends SubjectState {}

class SubjectCreateSuccess extends SubjectState {}

class SubjectCreateFailure extends SubjectState {
  String error;

  SubjectCreateFailure({required this.error});
}

//Fetch the subject
class SubjectFetchInProgress extends SubjectState {}

class SubjectFetchSuccess extends SubjectState {
  final List<SubjectModel> subjects;

  SubjectFetchSuccess({required this.subjects});
}

class SubjectFetchFailure extends SubjectState {
  final String error;

  SubjectFetchFailure({required this.error});
}
