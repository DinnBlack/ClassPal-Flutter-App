import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/state/app_state.dart';
import '../../data/student_firebase.dart';
import '../../model/student_group_model.dart';

part 'student_group_event.dart';
part 'student_group_state.dart';

class StudentGroupBloc extends Bloc<StudentGroupEvent, StudentGroupState> {
  final StudentFirebase _studentFirebase;
  final StreamController<void> _fetchStreamController =
  StreamController<void>.broadcast();

  Stream<void> get fetchStream => _fetchStreamController.stream;
  StudentGroupBloc(this._studentFirebase) : super(StudentGroupInitial()) {
    on<StudentGroupCreateStarted>(_onStudentGroupCreateStarted);
    on<StudentGroupFetchStarted>(_onStudentGroupFetchStarted);
    on<StudentGroupUpdateStarted>(_onStudentGroupUpdateStarted);
    on<StudentGroupResetStarted>(_onStudentGroupResetStarted);
  }

  Future<void> _onStudentGroupResetStarted(
      StudentGroupResetStarted event, Emitter<StudentGroupState> emit) async {
    emit(StudentGroupInitial());
  }

  // Xử lý sự kiện tạo nhóm học sinh
  Future<void> _onStudentGroupCreateStarted(
      StudentGroupCreateStarted event, Emitter<StudentGroupState> emit) async {
    try {
      emit(StudentGroupCreateInProgress());
      bool success = await _studentFirebase.createStudentGroup(
        event.groupName,
        event.studentIds,
        AppState.getClass()!.classId,
      );

      if (success) {
        emit(StudentGroupCreateSuccess());
        emit(StudentGroupInitial());
        _fetchStreamController.add(null);
      } else {
        throw Exception("Failed to create student group");
      }
    } catch (e) {
      emit(StudentGroupCreateFailure(error: e.toString()));
    }
  }


// Xử lý sự kiện fetch nhóm học sinh
  Future<void> _onStudentGroupFetchStarted(
      StudentGroupFetchStarted event, Emitter<StudentGroupState> emit) async {
    try {
      emit(StudentGroupFetchInProgress());
      List<StudentGroupModel> studentGroups =
      await _studentFirebase.fetchStudentGroups(AppState.getClass()!.classId);

      if (studentGroups.isNotEmpty) {
        emit(StudentGroupFetchSuccess(studentGroups: studentGroups));
      } else {
        emit(StudentGroupFetchFailure(error: "No student groups found"));
      }
    } catch (e) {
      emit(StudentGroupFetchFailure(error: e.toString()));
    }
  }

// Xử lý sự kiện cập nhật nhóm học sinh
  Future<void> _onStudentGroupUpdateStarted(
      StudentGroupUpdateStarted event, Emitter<StudentGroupState> emit) async {
    try {
      emit(StudentGroupUpdateInProgress());
      bool success = await _studentFirebase.updateStudentGroup(
        event.groupId,
        event.newGroupName,
        event.updatedStudentIds,
        AppState.getClass()!.classId,
      );

      if (success) {
        emit(StudentGroupUpdateSuccess());
        emit(StudentGroupInitial());
        _fetchStreamController.add(null);
      } else {
        throw Exception("Failed to update student group");
      }
    } catch (e) {
      emit(StudentGroupUpdateFailure(error: e.toString()));
    }
  }
}
