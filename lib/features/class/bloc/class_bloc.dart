import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/state/app_state.dart';
import '../../teacher/model/teacher_model.dart';
import '../data/class_firebase.dart';
import '../model/class_model.dart';

part 'class_event.dart';

part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassFirebase _classFirebase;
  final StreamController<void> _fetchStreamController =
      StreamController<void>.broadcast();

  Stream<void> get fetchStream => _fetchStreamController.stream;

  ClassBloc(this._classFirebase) : super(ClassInitial()) {
    on<ClassCreateStarted>(_onClassCreateStarted);
    on<ClassFetchStarted>(_onClassFetchStarted);
    on<ClassResetStarted>(_onClassResetStarted);
    on<ClassInviteTeacherStarted>(_onClassInviteTeacherStarted);
    on<ClassJoinStarted>(_onClassJoinStarted);
  }

  @override
  Future<void> close() {
    _fetchStreamController.close();
    return super.close();
  }

  Future<void> _onClassResetStarted(
      ClassResetStarted event, Emitter<ClassState> emit) async {
    emit(ClassInitial());
  }

  Future<void> _onClassCreateStarted(
      ClassCreateStarted event, Emitter<ClassState> emit) async {
    emit(ClassCreateInProgress());
    try {
      var currentUser = AppState.getUser();
      if (currentUser == null) {
        emit(ClassCreateFailure('User not found'));
        return;
      }

      ClassModel newClass = ClassModel(
        classId: '',
        className: event.className,
        schoolId: '',
        creatorId: currentUser.userId,
        isPersonalClass: false,
        students: [],
        teachers: [
          TeacherModel(
              uid: currentUser.userId, role: 'Giáo viên', canEdit: true)
        ],
        groups: [],
      );

      String classId = await _classFirebase.createClass(newClass);
      if (classId.isNotEmpty) {
        emit(ClassCreateSuccess());
        emit(ClassInitial());
        _fetchStreamController.add(null);
      } else {
        emit(ClassCreateFailure('Class creation failed'));
        emit(ClassInitial());
        add(ClassFetchStarted());
      }
    } catch (e, stackTrace) {
      print("Error creating class: $e");
      print("Stack trace: $stackTrace");
      emit(ClassCreateFailure('Class creation failed'));
    }
  }

  // Xử lý việc tải danh sách lớp học
  Future<void> _onClassFetchStarted(
      ClassFetchStarted event, Emitter<ClassState> emit) async {
    emit(ClassFetchInProgress());
    try {
      List<ClassModel> classes = await _classFirebase.fetchClasses();
      emit(ClassFetchSuccess(classes));
    } catch (e) {
      emit(ClassFetchFailure("Error fetching classes: $e"));
    }
  }

  // Xử lý việc mời giáo viên tham gia lớp học
  Future<void> _onClassInviteTeacherStarted(
      ClassInviteTeacherStarted event, Emitter<ClassState> emit) async {
    emit(ClassInviteTeacherInProgress());
    try {
      if (!_isValidEmail(event.teacherEmail)) {
        emit(ClassInviteTeacherFailure('Email không hợp lệ.'));
        return;
      }

      String result = await _classFirebase.inviteTeacher(event.teacherEmail);
      if (result == 'Lời mời đã được gửi thành công đến giáo viên!') {
        emit(ClassInviteTeacherSuccess());
      } else {
        emit(ClassInviteTeacherFailure(result));
      }
    } catch (e) {
      print('Error inviting teacher: $e');
      emit(ClassInviteTeacherFailure('Có lỗi xảy ra khi gửi lời mời'));
    }
  }

  // Kiểm tra tính hợp lệ của email
  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Xử lý việc gia nhập lớp học
  Future<void> _onClassJoinStarted(
      ClassJoinStarted event, Emitter<ClassState> emit) async {
    emit(ClassJoinInProgress());
    try {
      await _classFirebase.joinClass(event.classId);
      emit(ClassJoinSuccess());
      emit(ClassInitial());
      _fetchStreamController.add(null);
    } catch (e) {
      print('Error joining class: $e');
      emit(ClassJoinFailure('Error joining class: $e'));
    }
  }
}
