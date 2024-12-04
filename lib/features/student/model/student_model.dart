import '../../class/model/score_model.dart';

class StudentModel {
  final String id;
  final String? uid;
  final String name;
  final String birthDate;
  final String gender;
  final String image;
  final List<ScoreModel> scores;
  final String? parentId;

  //<editor-fold desc="Data Methods">
  const StudentModel({
    required this.id,
    this.uid,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.image,
    required this.scores,
    this.parentId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          birthDate == other.birthDate &&
          gender == other.gender &&
          image == other.image &&
          scores == other.scores &&
          uid == other.uid &&
          parentId == other.parentId);

  @override
  int get hashCode =>
      id.hashCode ^
      (uid?.hashCode ?? 0) ^
      name.hashCode ^
      birthDate.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      scores.hashCode ^
      (parentId?.hashCode ?? 0);

  @override
  String toString() {
    return 'StudentModel{' +
        ' id: $id,' +
        ' uid: $uid,' +
        ' name: $name,' +
        ' birthDate: $birthDate,' +
        ' gender: $gender,' +
        ' image: $image,' +
        ' scores: $scores,' +
        ' parentId: $parentId,' +
        '}';
  }

  StudentModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? birthDate,
    String? gender,
    String? image,
    List<ScoreModel>? scores,
    String? parentId,
  }) {
    return StudentModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      scores: scores ?? this.scores,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uid': this.uid,
      'name': this.name,
      'birthDate': this.birthDate,
      'gender': this.gender,
      'image': this.image,
      'scores': this.scores,
      'parentId': this.parentId,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      uid: map['uid'] as String?,
      name: map['name'] as String,
      birthDate: map['birthDate'] as String,
      gender: map['gender'] as String,
      image: map['image'] as String,
      scores: List<ScoreModel>.from(
          (map['scores'] as List).map((x) => ScoreModel.fromMap(x))),
      parentId: map['parentId'] as String?,
    );
  }

//</editor-fold>
}
