import 'package:bloc/bloc.dart';
import 'package:flutter_class_pal/features/class/data/class_firebase.dart';
import 'package:meta/meta.dart';

import '../../model/subject_model.dart';

part 'subject_state.dart';

class SubjectCubit extends Cubit<SubjectState> {
  final ClassFirebase _classFirebase;

  SubjectCubit(this._classFirebase) : super(SubjectInitial());

  Future<void> createSubject(String name, List<String> scoreType) async {
    emit(SubjectCreateInProgress());
    try {
      await _classFirebase.createSubject(name, scoreType);
      emit(SubjectCreateSuccess());
    } catch (e) {
      print('Error creating subject: $e');
      emit(SubjectCreateFailure(error: e.toString()));
    }
  }

  Future<void> fetchSubjects() async {
    emit(SubjectFetchInProgress());
    try {
      List<SubjectModel> subjects = await _classFirebase.fetchSubjects();
      print(subjects);
      emit(SubjectFetchSuccess(subjects: subjects));
    } catch (e) {
      print('Error fetching subjects: $e');
      emit(SubjectFetchFailure(error: e.toString()));
    }
  }
}
