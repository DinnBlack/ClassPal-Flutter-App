class AttendanceRecordModel {
  final DateTime date;
  final Map<String, String> studentAttendance;

//<editor-fold desc="Data Methods">
  const AttendanceRecordModel({
    required this.date,
    required this.studentAttendance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRecordModel &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          studentAttendance == other.studentAttendance);

  @override
  int get hashCode => date.hashCode ^ studentAttendance.hashCode;

  @override
  String toString() {
    return 'AttendanceRecordModel{' +
        ' date: $date,' +
        ' studentAttendance: $studentAttendance,' +
        '}';
  }

  AttendanceRecordModel copyWith({
    DateTime? date,
    Map<String, String>? studentAttendance,
  }) {
    return AttendanceRecordModel(
      date: date ?? this.date,
      studentAttendance: studentAttendance ?? this.studentAttendance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'studentAttendance': this.studentAttendance,
    };
  }

  factory AttendanceRecordModel.fromMap(Map<String, dynamic> map) {
    return AttendanceRecordModel(
      date: map['date'] as DateTime,
      studentAttendance: map['studentAttendance'] as Map<String, String>,
    );
  }

//</editor-fold>
}
