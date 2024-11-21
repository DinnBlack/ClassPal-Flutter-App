import '../../class/model/score_model.dart';

class StudentModel {
  final String id;
  final String? uid;
  final String name;
  final String birthDate;
  final String gender;
  final String image;
  final List<ScoreModel> scores;

  //<editor-fold desc="Data Methods">
  const StudentModel({
    required this.id,
    this.uid,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.image,
    required this.scores,
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
              uid == other.uid);

  @override
  int get hashCode =>
      id.hashCode ^
      (uid?.hashCode ?? 0) ^ // Nếu uid là null thì sẽ không tính vào hashCode
      name.hashCode ^
      birthDate.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      scores.hashCode;

  @override
  String toString() {
    return 'StudentModel{' +
        ' id: $id,' +
        ' uid: $uid,' + // Thêm uid vào chuỗi toString
        ' name: $name,' +
        ' birthDate: $birthDate,' +
        ' gender: $gender,' +
        ' image: $image,' +
        ' scores: $scores,' +
        '}';
  }

  StudentModel copyWith({
    String? id,
    String? uid, // uid có thể được cập nhật
    String? name,
    String? birthDate,
    String? gender,
    String? image,
    List<ScoreModel>? scores,
  }) {
    return StudentModel(
      id: id ?? this.id,
      uid: uid ?? this.uid, // Sử dụng uid cũ nếu không truyền vào
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      scores: scores ?? this.scores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uid': this.uid, // Bao gồm uid trong Map
      'name': this.name,
      'birthDate': this.birthDate,
      'gender': this.gender,
      'image': this.image,
      'scores': this.scores,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      uid: map['uid'] as String?, // uid có thể là null
      name: map['name'] as String,
      birthDate: map['birthDate'] as String,
      gender: map['gender'] as String,
      image: map['image'] as String,
      scores: List<ScoreModel>.from(
          (map['scores'] as List).map((x) => ScoreModel.fromMap(x))),
    );
  }

//</editor-fold>
}
