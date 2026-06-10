import 'package:flutter/material.dart';
import 'package:gradelens/core/constants/app_constants.dart';
import 'package:gradelens/models/semester_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  late final Box<dynamic> _semesterBox;
  late final Box<dynamic> _settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _semesterBox = await Hive.openBox<dynamic>(AppConstants.semestersBox);
    _settingsBox = await Hive.openBox<dynamic>(AppConstants.settingsBox);
  }

  List<SemesterModel> loadSemesters() {
    return _semesterBox.values
        .whereType<Map<dynamic, dynamic>>()
        .map(SemesterModel.fromMap)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveSemester(SemesterModel semester) async {
    await _semesterBox.put(semester.id, semester.toMap());
  }

  Future<void> deleteSemester(String id) async {
    await _semesterBox.delete(id);
  }

  ThemeMode loadThemeMode() {
    return switch (_settingsBox.get(AppConstants.themeModeKey) as String?) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _settingsBox.put(AppConstants.themeModeKey, mode.name);
  }
}
