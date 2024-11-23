import '../../student/model/student_group_model.dart';
import '../../student/model/student_model.dart';
import '../../teacher/model/teacher_model.dart';
import 'attendance_record_model.dart';

class ClassModel {
  String classId;
  String creatorId;
  String className;
  String? schoolId;
  List<TeacherModel> teachers;
  List<StudentModel> students;
  bool isPersonalClass;
  final List<AttendanceRecordModel>? attendanceRecords;
  final List<StudentGroupModel>? groups;

  ClassModel({
    required this.classId,
    required this.creatorId,
    required this.className,
    this.schoolId,
    required this.teachers,
    required this.students,
    required this.isPersonalClass,
    this.attendanceRecords,
    this.groups,
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
          teachers == other.teachers &&
          students == other.students &&
          isPersonalClass == other.isPersonalClass &&
          attendanceRecords == other.attendanceRecords &&
          groups == other.groups);

  @override
  int get hashCode =>
      classId.hashCode ^
      creatorId.hashCode ^
      className.hashCode ^
      schoolId.hashCode ^
      teachers.hashCode ^
      students.hashCode ^
      isPersonalClass.hashCode ^
      (attendanceRecords?.hashCode ?? 0) ^
      groups.hashCode; // Thêm groups vào hashCode

  @override
  String toString() {
    return 'ClassModel{' +
        ' classId: $classId,' +
        ' creatorId: $creatorId,' +
        ' className: $className,' +
        ' schoolId: $schoolId,' +
        ' teachers: $teachers,' +
        ' students: $students,' +
        ' isPersonalClass: $isPersonalClass,' +
        ' groups: $groups,' +
        '}';
  }

  ClassModel copyWith({
    String? classId,
    String? creatorId,
    String? className,
    String? schoolId,
    List<TeacherModel>? teachers,
    List<StudentModel>? students,
    bool? isPersonalClass,
    List<AttendanceRecordModel>? attendanceRecords,
    List<StudentGroupModel>? groups,
  }) {
    return ClassModel(
      classId: classId ?? this.classId,
      creatorId: creatorId ?? this.creatorId,
      className: className ?? this.className,
      schoolId: schoolId ?? this.schoolId,
      teachers: teachers ?? this.teachers,
      students: students ?? this.students,
      isPersonalClass: isPersonalClass ?? this.isPersonalClass,
      attendanceRecords: attendanceRecords ?? this.attendanceRecords,
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': this.classId,
      'creatorId': this.creatorId,
      'className': this.className,
      'schoolId': this.schoolId,
      'teachers': teachers.map((e) => e.toMap()).toList(),
      'students': students.map((e) => e.toMap()).toList(),
      'isPersonalClass': this.isPersonalClass,
      'attendanceRecords': attendanceRecords?.map((e) => e.toMap()).toList(),
      'groups': groups?.map((e) => e.toMap()).toList(),
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    print("Raw groups data: ${map['groups']}"); // Debug giá trị groups
    return ClassModel(
      classId: map['classId'] as String,
      creatorId: map['creatorId'] as String,
      className: map['className'] as String,
      schoolId: map['schoolId'] as String?,
      teachers: (map['teachers'] as List<dynamic>?)
              ?.map((e) => TeacherModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      students: (map['students'] as List<dynamic>?)
              ?.map((e) => StudentModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      isPersonalClass: map['isPersonalClass'] as bool,
      attendanceRecords: map['attendanceRecords'] != null
          ? (map['attendanceRecords'] as List<dynamic>)
              .map((e) =>
                  AttendanceRecordModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
      groups: map['groups'] != null
          ? (map['groups'] as List<dynamic>)
              .map((e) => StudentGroupModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
