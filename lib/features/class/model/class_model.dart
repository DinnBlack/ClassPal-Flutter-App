class ClassModel {
  String classId;
  String creatorId;
  String className;
  String? schoolId;
  List<String> teacherIds;
  List<String> studentIds;
  bool isPersonalClass;

//<editor-fold desc="Data Methods">
  ClassModel({
    required this.classId,
    required this.creatorId,
    required this.className,
    this.schoolId,
    required this.teacherIds,
    required this.studentIds,
    required this.isPersonalClass,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassModel &&
          runtimeType == other.runtimeType &&
          classId == other.classId &&
          creatorId == other.creatorId &&
          className == other.className &&
          schoolId == other.schoolId &&
          teacherIds == other.teacherIds &&
          studentIds == other.studentIds &&
          isPersonalClass == other.isPersonalClass);

  @override
  int get hashCode =>
      classId.hashCode ^
      creatorId.hashCode ^
      className.hashCode ^
      schoolId.hashCode ^
      teacherIds.hashCode ^
      studentIds.hashCode ^
      isPersonalClass.hashCode;

  @override
  String toString() {
    return 'ClassModel{' +
        ' classId: $classId,' +
        ' creatorId: $creatorId,' +
        ' className: $className,' +
        ' schoolId: $schoolId,' +
        ' teacherIds: $teacherIds,' +
        ' studentIds: $studentIds,' +
        ' isPersonalClass: $isPersonalClass,' +
        '}';
  }

  ClassModel copyWith({
    String? classId,
    String? creatorId,
    String? className,
    String? schoolId,
    List<String>? teacherIds,
    List<String>? studentIds,
    bool? isPersonalClass,
  }) {
    return ClassModel(
      classId: classId ?? this.classId,
      creatorId: creatorId ?? this.creatorId,
      className: className ?? this.className,
      schoolId: schoolId ?? this.schoolId,
      teacherIds: teacherIds ?? this.teacherIds,
      studentIds: studentIds ?? this.studentIds,
      isPersonalClass: isPersonalClass ?? this.isPersonalClass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': this.classId,
      'creatorId': this.creatorId,
      'className': this.className,
      'schoolId': this.schoolId,
      'teacherIds': this.teacherIds,
      'studentIds': this.studentIds,
      'isPersonalClass': this.isPersonalClass,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      classId: map['classId'] as String,
      creatorId: map['creatorId'] as String,
      className: map['className'] as String,
      schoolId: map['schoolId'] as String,
      teacherIds: map['teacherIds'] as List<String>,
      studentIds: map['studentIds'] as List<String>,
      isPersonalClass: map['isPersonalClass'] as bool,
    );
  }

//</editor-fold>
}