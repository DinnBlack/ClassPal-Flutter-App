class UserModel {
  String userId;
  String name;
  String email;
  String password;
  String role;
  String gender;
  List<String> schoolsIds;
  List<String> classesIds;
  List<String>? childrenIds;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.schoolsIds,
    required this.classesIds,
    this.childrenIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          role == other.role &&
          gender == other.gender &&
          schoolsIds == other.schoolsIds &&
          classesIds == other.classesIds &&
          childrenIds == other.childrenIds);

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      role.hashCode ^
      gender.hashCode ^
      schoolsIds.hashCode ^
      classesIds.hashCode ^
      childrenIds.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' userId: $userId,' +
        ' name: $name,' +
        ' email: $email,' +
        ' password: $password,' +
        ' role: $role,' +
        ' gender: $gender,' +
        ' schoolsIds: $schoolsIds,' +
        ' classesIds: $classesIds,' +
        ' childrenIds: $childrenIds,' +
        '}';
  }

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? password,
    String? role,
    String? gender,
    List<String>? schoolsIds,
    List<String>? classesIds,
    List<String>? childrenIds,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      schoolsIds: schoolsIds ?? this.schoolsIds,
      classesIds: classesIds ?? this.classesIds,
      childrenIds: childrenIds ?? this.childrenIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'role': this.role,
      'gender': this.gender,
      'schoolsIds': this.schoolsIds,
      'classesIds': this.classesIds,
      'childrenIds': this.childrenIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      gender: map['gender'] as String,
      schoolsIds: List<String>.from(map['schoolsIds'] ?? []),
      classesIds: List<String>.from(map['classesIds'] ?? []),
      childrenIds: List<String>.from(map['childrenIds'] ?? []),
    );
  }

//</editor-fold>
}
