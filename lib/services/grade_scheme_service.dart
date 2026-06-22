import 'package:gradelens/models/university_grade_scheme.dart';

class GradeSchemeService {
  const GradeSchemeService._();

  static const schemes = [
    UniversityGradeScheme(
      universityName: 'Anna University',
      gradeMapping:{'O': 10, 'A+': 9, 'A': 8, 'B+': 7, 'B': 6, 'C': 5, 'RA': 0},
    ),
    UniversityGradeScheme(
      universityName: 'VIT',
      gradeMapping: {'S': 10, 'A': 9, 'B': 8, 'C': 7, 'D': 6, 'E': 5, 'F': 0},
    ),
    UniversityGradeScheme(
      universityName: 'SRM',
      gradeMapping: {'O': 10, 'A+': 9, 'A': 8, 'B+': 7, 'B': 6, 'C': 5, 'F': 0},
    ),
  ];
}
