class ScoreModel {
  final String subjectName;
  final Map<String, double> scores;

//<editor-fold desc="Data Methods">
  const ScoreModel({
    required this.subjectName,
    required this.scores,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScoreModel &&
          runtimeType == other.runtimeType &&
          subjectName == other.subjectName &&
          scores == other.scores);

  @override
  int get hashCode => subjectName.hashCode ^ scores.hashCode;

  @override
  String toString() {
    return 'ScoreModel{' +
        ' subjectName: $subjectName,' +
        ' scores: $scores,' +
        '}';
  }

  ScoreModel copyWith({
    String? subjectName,
    Map<String, double>? scores,
  }) {
    return ScoreModel(
      subjectName: subjectName ?? this.subjectName,
      scores: scores ?? this.scores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectName': this.subjectName,
      'scores': this.scores,
    };
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      subjectName: map['subjectName'] as String,
      scores: map['scores'] as Map<String, double>,
    );
  }

//</editor-fold>
}