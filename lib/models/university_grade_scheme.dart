class UniversityGradeScheme {
  const UniversityGradeScheme({
    required this.universityName,
    required this.gradeMapping,
  });

  final String universityName;
  final Map<String, double> gradeMapping;
}
