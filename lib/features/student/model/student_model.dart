import '../../class/model/score_model.dart';

class StudentModel {
  final String id;
  final String name;
  final DateTime birthDate;
  final String gender;
  final String image;
  final List<ScoreModel> scores;

//<editor-fold desc="Data Methods">
  const StudentModel({
    required this.id,
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
          scores == other.scores);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      birthDate.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      scores.hashCode;

  @override
  String toString() {
    return 'StudentModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' birthDate: $birthDate,' +
        ' gender: $gender,' +
        ' image: $image,' +
        ' scores: $scores,' +
        '}';
  }

  StudentModel copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? gender,
    String? image,
    List<ScoreModel>? scores,
  }) {
    return StudentModel(
      id: id ?? this.id,
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
      name: map['name'] as String,
      birthDate: map['birthDate'] as DateTime,
      gender: map['gender'] as String,
      image: map['image'] as String,
      scores: map['scores'] as List<ScoreModel>,
    );
  }

//</editor-fold>
}