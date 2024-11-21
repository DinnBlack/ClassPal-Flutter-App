class TeacherModel {
  String uid;
  String role;

//<editor-fold desc="Data Methods">
  TeacherModel({
    required this.uid,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          role == other.role);

  @override
  int get hashCode => uid.hashCode ^ role.hashCode;

  @override
  String toString() {
    return 'TeacherModel{' + ' uid: $uid,' + ' role: $role,' + '}';
  }

  TeacherModel copyWith({
    String? uid,
    String? role,
  }) {
    return TeacherModel(
      uid: uid ?? this.uid,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'role': this.role,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      uid: map['uid'] as String,
      role: map['role'] as String,
    );
  }

//</editor-fold>
}