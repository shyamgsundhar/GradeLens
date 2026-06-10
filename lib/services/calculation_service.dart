import 'package:gradelens/models/semester_model.dart';
import 'package:gradelens/models/subject_model.dart';

class GpaResult {
  const GpaResult({
    required this.gpa,
    required this.totalCredits,
    required this.weightedPoints,
  });

  final double gpa;
  final int totalCredits;
  final double weightedPoints;
}

class CgpaResult {
  const CgpaResult({
    required this.cgpa,
    required this.totalCredits,
    required this.semesterCount,
  });

  final double cgpa;
  final int totalCredits;
  final int semesterCount;
}

class CalculationService {
  const CalculationService();

  GpaResult calculateGpa(List<SubjectModel> subjects) {
    final totalCredits = subjects.fold<int>(
      0,
      (sum, subject) => sum + subject.credits,
    );
    final weightedPoints = subjects.fold<double>(
      0,
      (sum, subject) => sum + subject.weightedPoints,
    );

    return GpaResult(
      gpa: totalCredits == 0 ? 0 : weightedPoints / totalCredits,
      totalCredits: totalCredits,
      weightedPoints: weightedPoints,
    );
  }

  CgpaResult calculateCgpa(List<SemesterModel> semesters) {
    final totalCredits = semesters.fold<int>(
      0,
      (sum, semester) => sum + semester.credits,
    );
    final weightedPoints = semesters.fold<double>(
      0,
      (sum, semester) => sum + semester.weightedPoints,
    );

    return CgpaResult(
      cgpa: totalCredits == 0 ? 0 : weightedPoints / totalCredits,
      totalCredits: totalCredits,
      semesterCount: semesters.length,
    );
  }
}
