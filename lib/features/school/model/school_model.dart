class SchoolModel {
  String schoolId;
  String schoolName;
  String adminId;
  List<String> teacherIds;
  List<String> classIds;

//<editor-fold desc="Data Methods">
  SchoolModel({
    required this.schoolId,
    required this.schoolName,
    required this.adminId,
    required this.teacherIds,
    required this.classIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchoolModel &&
          runtimeType == other.runtimeType &&
          schoolId == other.schoolId &&
          schoolName == other.schoolName &&
          adminId == other.adminId &&
          teacherIds == other.teacherIds &&
          classIds == other.classIds);

  @override
  int get hashCode =>
      schoolId.hashCode ^
      schoolName.hashCode ^
      adminId.hashCode ^
      teacherIds.hashCode ^
      classIds.hashCode;

  @override
  String toString() {
    return 'SchoolModel{' +
        ' schoolId: $schoolId,' +
        ' schoolName: $schoolName,' +
        ' adminId: $adminId,' +
        ' teacherIds: $teacherIds,' +
        ' classIds: $classIds,' +
        '}';
  }

  SchoolModel copyWith({
    String? schoolId,
    String? schoolName,
    String? adminId,
    List<String>? teacherIds,
    List<String>? classIds,
  }) {
    return SchoolModel(
      schoolId: schoolId ?? this.schoolId,
      schoolName: schoolName ?? this.schoolName,
      adminId: adminId ?? this.adminId,
      teacherIds: teacherIds ?? this.teacherIds,
      classIds: classIds ?? this.classIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'schoolId': this.schoolId,
      'schoolName': this.schoolName,
      'adminId': this.adminId,
      'teacherIds': this.teacherIds,
      'classIds': this.classIds,
    };
  }

  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    return SchoolModel(
      schoolId: map['schoolId'] as String,
      schoolName: map['schoolName'] as String,
      adminId: map['adminId'] as String,
      teacherIds: map['teacherIds'] as List<String>,
      classIds: map['classIds'] as List<String>,
    );
  }

//</editor-fold>
}