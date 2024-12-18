class TeacherModel {
  String? uid;
  String? role;
  bool? canEdit; // Trường có thể null
  String? email; // Thêm trường email
  bool? isActive; // Thêm trường trạng thái tham gia lớp học

//<editor-fold desc="Data Methods">
  TeacherModel({
    this.uid,      // Trường có thể null
    this.role,     // Trường có thể null
    this.canEdit,  // Trường có thể null
    this.email,    // Trường có thể null
    this.isActive, // Trường có thể null
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is TeacherModel &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              role == other.role &&
              canEdit == other.canEdit &&
              email == other.email &&
              isActive == other.isActive); // Cập nhật so sánh

  @override
  int get hashCode =>
      uid.hashCode ^
      role.hashCode ^
      canEdit.hashCode ^
      email.hashCode ^
      isActive.hashCode; // Cập nhật hashCode

  @override
  String toString() {
    return 'TeacherModel{' +
        ' uid: $uid,' +
        ' role: $role,' +
        ' canEdit: $canEdit,' +
        ' email: $email,' + // Cập nhật toString
        ' isActive: $isActive,' +
        '}';
  }

  TeacherModel copyWith({
    String? uid,
    String? role,
    bool? canEdit,
    String? email,
    bool? isActive,
  }) {
    return TeacherModel(
      uid: uid ?? this.uid,
      role: role ?? this.role,
      canEdit: canEdit ?? this.canEdit,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'role': this.role,
      'canEdit': this.canEdit,
      'email': this.email,
      'isActive': this.isActive,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      uid: map['uid'] as String?,
      role: map['role'] as String?,
      canEdit: map['canEdit'] as bool?,
      email: map['email'] as String?,
      isActive: map['isActive'] as bool?,
    );
  }
//</editor-fold>
}
