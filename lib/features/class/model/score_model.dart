import 'package:flutter_class_pal/features/class/model/score_type_model.dart';

class ScoreModel {
  final String studentId;
  final String studentName;
  final List<ScoreTypeModel> scoreTypes;

//<editor-fold desc="Data Methods">
  const ScoreModel({
    required this.studentId,
    required this.studentName,
    required this.scoreTypes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScoreModel &&
          runtimeType == other.runtimeType &&
          studentId == other.studentId &&
          studentName == other.studentName &&
          scoreTypes == other.scoreTypes);

  @override
  int get hashCode =>
      studentId.hashCode ^ studentName.hashCode ^ scoreTypes.hashCode;

  @override
  String toString() {
    return 'ScoreModel{' +
        ' studentId: $studentId,' +
        ' studentName: $studentName,' +
        ' scoreTypes: $scoreTypes,' +
        '}';
  }

  ScoreModel copyWith({
    String? studentId,
    String? studentName,
    List<ScoreTypeModel>? scoreTypes,
  }) {
    return ScoreModel(
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      scoreTypes: scoreTypes ?? this.scoreTypes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': this.studentId,
      'studentName': this.studentName,
      'scoreTypes': this.scoreTypes.map((scoreType) => scoreType.toMap()).toList(),
    };
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      studentId: map['studentId'] as String,
      studentName: map['studentName'] as String,
      scoreTypes: (map['scoreTypes'] as List<dynamic>).map((item) => ScoreTypeModel.fromMap(item)).toList(),
    );
  }

//</editor-fold>
}