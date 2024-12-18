import 'package:flutter_class_pal/features/class/model/score_model.dart';

class SubjectModel {
  final String name;
  final String imageUrl;
  final List<ScoreModel> scores;

//<editor-fold desc="Data Methods">
  const SubjectModel({
    required this.name,
    required this.imageUrl,
    required this.scores,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          imageUrl == other.imageUrl &&
          scores == other.scores);

  @override
  int get hashCode =>
      name.hashCode ^
      imageUrl.hashCode ^
      scores.hashCode;

  @override
  String toString() {
    return 'SubjectModel{' +
        ' name: $name,' +
        ' imageUrl: $imageUrl,' +
        ' scores: $scores,' +
        '}';
  }

  SubjectModel copyWith({
    String? name,
    String? teacher,
    String? imageUrl,
    List<ScoreModel>? scores,
  }) {
    return SubjectModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      scores: scores ?? this.scores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'imageUrl': this.imageUrl,
      'scores': this.scores.map((score) => score.toMap()).toList(),
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      scores: (map['scores'] as List<dynamic>).map((item) => ScoreModel.fromMap(item)).toList(),
    );
  }


//</editor-fold>
}