class UserModel {
  String userId;
  String name;
  String email;
  Map<String, bool> roles;
  List<String> schoolsIds;
  List<String> classesIds;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.roles,
    required this.schoolsIds,
    required this.classesIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          email == other.email &&
          roles == other.roles &&
          schoolsIds == other.schoolsIds &&
          classesIds == other.classesIds);

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      email.hashCode ^
      roles.hashCode ^
      schoolsIds.hashCode ^
      classesIds.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' userId: $userId,' +
        ' name: $name,' +
        ' email: $email,' +
        ' roles: $roles,' +
        ' schoolsIds: $schoolsIds,' +
        ' classesIds: $classesIds,' +
        '}';
  }

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    Map<String, bool>? roles,
    List<String>? schoolsIds,
    List<String>? classesIds,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      schoolsIds: schoolsIds ?? this.schoolsIds,
      classesIds: classesIds ?? this.classesIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'name': this.name,
      'email': this.email,
      'roles': this.roles,
      'schoolsIds': this.schoolsIds,
      'classesIds': this.classesIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      roles: map['roles'] as Map<String, bool>,
      schoolsIds: map['schoolsIds'] as List<String>,
      classesIds: map['classesIds'] as List<String>,
    );
  }

//</editor-fold>
}