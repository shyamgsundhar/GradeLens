import 'package:flutter/material.dart';
import 'package:gradelens/core/exceptions/app_exception.dart';
import 'package:gradelens/models/semester_model.dart';
import 'package:gradelens/services/calculation_service.dart';
import 'package:gradelens/services/storage_service.dart';

class AppState extends ChangeNotifier {
  AppState(this._storageService);

  final StorageService _storageService;
  final _calculationService = const CalculationService();

  ThemeMode themeMode = ThemeMode.system;
  List<SemesterModel> semesters = [];
  bool isLoaded = false;
  bool isBusy = false;
  String? errorMessage;

  CgpaResult get cgpa => _calculationService.calculateCgpa(semesters);

  Future<void> load() async {
    isBusy = true;
    notifyListeners();
    try {
        themeMode = _storageService.loadThemeMode();
        semesters = _storageService.loadSemesters();
        isLoaded = true;
      _clearError();
    } catch (error) {
      _setError('Could not load saved GradeLens data.');
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final previousMode = themeMode;
    themeMode = mode;
    notifyListeners();
    try {
      await _storageService.saveThemeMode(mode);
      _clearError();
    } catch (error) {
      themeMode = previousMode;
      _setError('Could not save theme preference.');
      throw AppException(errorMessage!, error);
    } finally {
      notifyListeners();
    }
  }

  Future<void> saveSemester(SemesterModel semester) async {
    await _run(
      () async {
        await _storageService.saveSemester(semester);
        semesters = _storageService.loadSemesters();
      },
      failureMessage: 'Could not save semester.',
    );
  }

  Future<void> deleteSemester(String id) async {
    await _run(
      () async {
        await _storageService.deleteSemester(id);
        semesters = _storageService.loadSemesters();
      },
      failureMessage: 'Could not delete semester.',
    );
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  Future<void> _run(
    Future<void> Function() action, {
    required String failureMessage,
  }) async {
    isBusy = true;
    _clearError();
    notifyListeners();
    try {
      await action();
    } catch (error) {
      _setError(failureMessage);
      throw AppException(failureMessage, error);
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  void _setError(String message) {
    errorMessage = message;
  }

  void _clearError() {
    errorMessage = null;
  }
}
