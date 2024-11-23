class StudentGroupModel {
  final List<String> students;
  final String name;

//<editor-fold desc="Data Methods">
  const StudentGroupModel({
    required this.students,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentGroupModel &&
          runtimeType == other.runtimeType &&
          students == other.students &&
          name == other.name);

  @override
  int get hashCode => students.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'StudentGroupModel{' +
        ' students: $students,' +
        ' name: $name,' +
        '}';
  }

  StudentGroupModel copyWith({
    List<String>? students,
    String? name,
  }) {
    return StudentGroupModel(
      students: students ?? this.students,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'students': this.students,
      'name': this.name,
    };
  }

  factory StudentGroupModel.fromMap(Map<String, dynamic> map) {
    return StudentGroupModel(
      name: map['groupName']?.toString() ?? '',
      students: (map['studentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [], // Default to empty list if null
    );
  }

//</editor-fold>
}