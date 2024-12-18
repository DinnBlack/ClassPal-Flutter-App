class ScoreTypeModel {
  final String typeName;
  final String score;
  final String note;

//<editor-fold desc="Data Methods">
  const ScoreTypeModel({
    required this.typeName,
    required this.score,
    required this.note,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScoreTypeModel &&
          runtimeType == other.runtimeType &&
          typeName == other.typeName &&
          score == other.score &&
          note == other.note);

  @override
  int get hashCode => typeName.hashCode ^ score.hashCode ^ note.hashCode;

  @override
  String toString() {
    return 'ScoreTypeModel{' +
        ' typeName: $typeName,' +
        ' score: $score,' +
        ' note: $note,' +
        '}';
  }

  ScoreTypeModel copyWith({
    String? typeName,
    String? score,
    String? note,
  }) {
    return ScoreTypeModel(
      typeName: typeName ?? this.typeName,
      score: score ?? this.score,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'typeName': this.typeName,
      'score': this.score,
      'note': this.note,
    };
  }

  factory ScoreTypeModel.fromMap(Map<String, dynamic> map) {
    return ScoreTypeModel(
      typeName: map['typeName'] as String,
      score: map['score'] as String,
      note: map['note'] as String,
    );
  }

//</editor-fold>
}