class ClassModel {
  String classId;
  String className;
  String schoolId;
  List<String> teacherIds;
  List<String> studentIds;

//<editor-fold desc="Data Methods">
  ClassModel({
    required this.classId,
    required this.className,
    required this.schoolId,
    required this.teacherIds,
    required this.studentIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassModel &&
          runtimeType == other.runtimeType &&
          classId == other.classId &&
          className == other.className &&
          schoolId == other.schoolId &&
          teacherIds == other.teacherIds &&
          studentIds == other.studentIds);

  @override
  int get hashCode =>
      classId.hashCode ^
      className.hashCode ^
      schoolId.hashCode ^
      teacherIds.hashCode ^
      studentIds.hashCode;

  @override
  String toString() {
    return 'ClassModel{' +
        ' classId: $classId,' +
        ' className: $className,' +
        ' schoolId: $schoolId,' +
        ' teacherIds: $teacherIds,' +
        ' studentIds: $studentIds,' +
        '}';
  }

  ClassModel copyWith({
    String? classId,
    String? className,
    String? schoolId,
    List<String>? teacherIds,
    List<String>? studentIds,
  }) {
    return ClassModel(
      classId: classId ?? this.classId,
      className: className ?? this.className,
      schoolId: schoolId ?? this.schoolId,
      teacherIds: teacherIds ?? this.teacherIds,
      studentIds: studentIds ?? this.studentIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': this.classId,
      'className': this.className,
      'schoolId': this.schoolId,
      'teacherIds': this.teacherIds,
      'studentIds': this.studentIds,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      classId: map['classId'] as String,
      className: map['className'] as String,
      schoolId: map['schoolId'] as String,
      teacherIds: map['teacherIds'] as List<String>,
      studentIds: map['studentIds'] as List<String>,
    );
  }

//</editor-fold>
}