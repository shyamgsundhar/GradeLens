class SubjectModel {
  const SubjectModel({
    required this.subjectName,
    required this.grade,
    required this.credits,
    required this.gradePoint,
  });

  final String subjectName;
  final String grade;
  final int credits;
  final double gradePoint;

  double get weightedPoints => credits * gradePoint;

  Map<String, dynamic> toMap() {
    return {
      'subjectName': subjectName,
      'grade': grade,
      'credits': credits,
      'gradePoint': gradePoint,
    };
  }

  factory SubjectModel.fromMap(Map<dynamic, dynamic> map) {
    return SubjectModel(
      subjectName: map['subjectName'] as String? ?? '',
      grade: map['grade'] as String? ?? '',
      credits: (map['credits'] as num?)?.toInt() ?? 0,
      gradePoint: (map['gradePoint'] as num?)?.toDouble() ?? 0,
    );
  }
}
