import 'package:gradelens/models/subject_model.dart';

class SemesterModel {
  const SemesterModel({
    required this.id,
    required this.semesterName,
    required this.universityName,
    required this.gpa,
    required this.credits,
    required this.createdAt,
    required this.subjects,
  });

  final String id;
  final String semesterName;
  final String universityName;
  final double gpa;
  final int credits;
  final DateTime createdAt;
  final List<SubjectModel> subjects;

  double get weightedPoints => gpa * credits;

  SemesterModel copyWith({String? semesterName}) {
    return SemesterModel(
      id: id,
      semesterName: semesterName ?? this.semesterName,
      universityName: universityName,
      gpa: gpa,
      credits: credits,
      createdAt: createdAt,
      subjects: subjects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'semesterName': semesterName,
      'universityName': universityName,
      'gpa': gpa,
      'credits': credits,
      'createdAt': createdAt.toIso8601String(),
      'subjects': subjects.map((subject) => subject.toMap()).toList(),
    };
  }

  factory SemesterModel.fromMap(Map<dynamic, dynamic> map) {
    final subjects = (map['subjects'] as List<dynamic>? ?? const [])
        .map((subject) => SubjectModel.fromMap(subject as Map<dynamic, dynamic>))
        .toList();

    return SemesterModel(
      id: map['id'] as String? ?? DateTime.now().microsecondsSinceEpoch.toString(),
      semesterName: map['semesterName'] as String? ?? 'Semester',
      universityName: map['universityName'] as String? ?? 'Unknown',
      gpa: (map['gpa'] as num?)?.toDouble() ?? 0,
      credits: (map['credits'] as num?)?.toInt() ?? 0,
      createdAt:
          DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
      subjects: subjects,
    );
  }
}
