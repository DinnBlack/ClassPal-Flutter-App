import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/state/app_state.dart';
import '../../../core/utils/id_generator.dart';
import '../data/class_firebase.dart';
import '../model/class_model.dart';

part 'class_event.dart';

part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassFirebase _classFirebase;

  ClassBloc(this._classFirebase) : super(ClassInitial()) {
    on<ClassCreateStarted>(_onClassCreateStarted);
    on<ClassFetchStarted>(_onClassFetchStarted);
  }

  Future<void> _onClassCreateStarted(
      ClassCreateStarted event, Emitter<ClassState> emit) async {
    emit(ClassCreateInProgress());
    try {
      var currentUser = AppState.getUser();
      if (currentUser == null) {
        emit(ClassCreateFailure());
        return;
      }

      ClassModel newClass = ClassModel(
        classId: generateClassId(),
        className: "New Class",
        schoolId: currentUser.schoolsIds.first,
        teacherIds: [currentUser.userId],
        studentIds: [],
        creatorId: currentUser.userId,
        isPersonalClass: false,
      );

      String classId = await _classFirebase.createClass(newClass);
      if (classId.isNotEmpty) {
        emit(ClassCreateSuccess());
      } else {
        emit(ClassCreateFailure());
      }
    } catch (e) {
      print("Error creating class: $e");
      emit(ClassCreateFailure());
    }
  }

  Future<void> _onClassFetchStarted(
      ClassFetchStarted event, Emitter<ClassState> emit) async {
    emit(ClassFetchInProgress());
    try {
      var currentUser = AppState.getUser();
      if (currentUser == null) {
        emit(ClassFetchFailure());
        return;
      }

      List<ClassModel> classes = await _classFirebase.fetchClasses();

      if (classes.isNotEmpty) {
        emit(ClassFetchSuccess(classes));
      } else {
        emit(ClassFetchFailure());
      }
    } catch (e) {
      print("Error fetching classes: $e");
      emit(ClassFetchFailure());
    }
  }
}
