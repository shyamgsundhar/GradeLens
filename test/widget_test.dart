import 'package:flutter_test/flutter_test.dart';
import 'package:gradelens/models/semester_model.dart';
import 'package:gradelens/models/subject_model.dart';
import 'package:gradelens/services/calculation_service.dart';

void main() {
  const service = CalculationService();

  test('calculates GPA with weighted credits', () {
    final result = service.calculateGpa(
      const [
        SubjectModel(
          subjectName: 'Math',
          grade: 'O',
          credits: 4,
          gradePoint: 10,
        ),
        SubjectModel(
          subjectName: 'Physics',
          grade: 'B',
          credits: 3,
          gradePoint: 6,
        ),
      ],
    );

    expect(result.totalCredits, 7);
    expect(result.weightedPoints, 58);
    expect(result.gpa, closeTo(8.2857, 0.0001));
  });

  test('calculates CGPA using weighted semester credits', () {
    final createdAt = DateTime(2026);
    final result = service.calculateCgpa(
      [
        SemesterModel(
          id: '1',
          semesterName: 'Semester 1',
          universityName: 'Anna University',
          gpa: 9,
          credits: 20,
          createdAt: createdAt,
          subjects: const [],
        ),
        SemesterModel(
          id: '2',
          semesterName: 'Semester 2',
          universityName: 'Anna University',
          gpa: 7,
          credits: 10,
          createdAt: createdAt,
          subjects: const [],
        ),
      ],
    );

    expect(result.semesterCount, 2);
    expect(result.totalCredits, 30);
    expect(result.cgpa, closeTo(8.3333, 0.0001));
  });
}
